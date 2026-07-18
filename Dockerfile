# ==========================================
# STAGE 1: Build the Frontend Assets via Webpack
# ==========================================
FROM node:20-alpine AS client-builder
WORKDIR /usr/src/app/client
COPY client/package*.json ./
RUN npm install
COPY client/ ./
RUN npm run build

# ==========================================
# STAGE 2: Set up the Production Server
# ==========================================
FROM node:20-alpine AS production-runner
WORKDIR /usr/src/app/server

# Install backend dependencies
COPY server/package*.json ./
RUN npm ci --omit=dev

# Copy backend source code
COPY server/ ./

# Create the clean public directory for static asset hosting
RUN mkdir -p ./public

# Copy the built client static assets from STAGE 1 Webpack output folder
COPY --from=client-builder /usr/src/app/client/public/ ./public/

# Set environment production flag
ENV NODE_ENV=production

# Apply Least Privilege Security Principle (Non-root user)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /usr/src/app
USER appuser

# Expose backend application port
EXPOSE 5000

# Start the production application
CMD ["npm", "start"]
