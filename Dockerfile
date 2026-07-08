# ==========================================
# STAGE 1: Build the Frontend Assets
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

# Create the public directory for static asset hosting
RUN mkdir -p ./public

# Copy the built client static assets from STAGE 1
# Note: React/Vite usually builds into a folder named 'build' or 'dist' inside the client.
COPY --from=client-builder /usr/src/app/client/build ./public

# Set environment production 
ENV NODE_ENV=production

# Apply Least Privilege Security Principle (Non-root user)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /usr/src/app
USER appuser

# Expose backend application port
EXPOSE 5000

# Start the production application
CMD ["npm", "start"]
