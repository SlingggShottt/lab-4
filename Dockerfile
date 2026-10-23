### Multi-Stage Dockerfile 

# Stage 1: Build Stage
FROM node:20-alpine AS builder

# working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy application source code
COPY . .

# Stage 2: Production Stage
FROM node:20-alpine AS production

# Set working directory
WORKDIR /app

# Copy only necessary files from build stage
COPY --from=builder /app /app

# Expose the application port
EXPOSE 10001

# Start the application
CMD ["node", "index.js"]
