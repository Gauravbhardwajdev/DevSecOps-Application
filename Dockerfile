# ==========================================
# STAGE 1: Build the Client/Frontend
# ==========================================
FROM node:20-alpine AS client-builder
WORKDIR /usr/src/app

# Install client dependencies and build
COPY client/package*.json ./client/
RUN cd client && npm ci
COPY client/ ./client/
RUN cd client && npm run build

# ==========================================
# STAGE 2: Set up the Production Server
# ==========================================
FROM node:20-alpine AS production-runner
WORKDIR /usr/src/app

# Install backend dependencies
COPY server/package*.json ./server/
RUN cd server && npm ci --omit=dev

# Copy backend source code
COPY server/ ./server/

# Copy the built client assets from Stage 1
COPY --from=client-builder /usr/src/app/client/public/ ./client/public/

# Set environment production flag
ENV NODE_ENV=production

# Apply Least Privilege Security Principle (Non-root user)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /usr/src/app
USER appuser

# Expose backend application port
EXPOSE 5000

# Start the production application from the server sub-folder
CMD ["npm", "start", "--prefix", "server"]
