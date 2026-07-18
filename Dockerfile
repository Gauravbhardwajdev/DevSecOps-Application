# ==========================================
# STAGE 2: Set up the Production Server
# ==========================================
FROM node:20-alpine AS production-runner
# 1. Change WORKDIR to the root app level so paths match the project layout
WORKDIR /usr/src/app

# Install backend dependencies
COPY server/package*.json ./server/
RUN cd server && npm ci --omit=dev

# Copy backend source code
COPY server/ ./server/

# 2. Copy the built client assets into the exact path server.js is looking for
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
