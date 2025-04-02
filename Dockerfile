# Dockerfile
### Stage 1: Build Stage
FROM node:22-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies early for better caching
COPY package.json package-lock.json ./
RUN npm ci --only=production

# Copy source files and build the application
COPY . .
RUN npm run build

### Stage 2: Serve with Nginx
FROM nginx:1.25-alpine AS production

# Remove default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy built files from previous stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom Nginx configuration (optional but recommended)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 8080 for serving the app
EXPOSE 8080

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
