# Dockerfile
# syntax=docker/dockerfile:1

ARG NODE_VERSION=22

### Stage 1: Build Stage
FROM node:${NODE_VERSION}-alpine AS build

# Set working directory
WORKDIR /app

# Install dependencies early for better caching
COPY package.json package-lock.json ./
# RUN npm ci --only=production
RUN npm ci

# Copy source files and build the application
COPY . .
RUN npm run build

### Stage 2: Test stage
FROM build AS test
RUN npm run lint && npm run test:unit

### Stage 3: Development stage - for local development with hot reloading
FROM node:${NODE_VERSION}-alpine AS development
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host"]

### Stage 4: Production stage - nginx to serve static files
FROM nginx:stable-alpine AS production

# Set working directory
WORKDIR /usr/share/nginx/html

# Remove default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy built files from previous stage
COPY --from=build /app/dist .

# Copy custom Nginx configuration (optional but recommended)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for serving the app
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
