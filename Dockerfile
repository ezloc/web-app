# Dockerfile
# syntax=docker/dockerfile:1

ARG NODE_VERSION=22

### Stage 1: Build Stage
FROM node:${NODE_VERSION}-alpine AS build

# Define environment variables
ENV HOME=/home/app

# Create application folder and assign rights to the node user
RUN mkdir -p $HOME && chown -R node:node $HOME

# Set working directory
WORKDIR $HOME

# Set the active user
USER node

# Copy package.json and package-lock.json from the host to $HOME
COPY --chown=node:node package.json package-lock.json $HOME

# Install application modules
# RUN npm ci --only=production
# RUN npm ci && npm cache clean --force
RUN npm install

# Copy source files and build the application
COPY --chown=node:node . .
RUN npm run build

### Stage 2: Test stage
FROM build AS test

# Set environment to test
ENV NODE_ENV=test

# Run linter and unit test
RUN npm run lint && npm run test:unit

### Stage 3: Development stage - for local development with hot reloading
FROM build AS development

# Set environment to development
ENV NODE_ENV=development

# Expose port on the host
EXPOSE 8080

# Launch application
CMD ["npm", "run", "serve"]
# CMD ["npm", "run", "dev", "--", "--host"]

### Stage 4: Production stage - nginx to serve static files
FROM nginx:stable-alpine AS production

# Set working directory
WORKDIR /usr/share/nginx/html

# Remove default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy built files from previous stage
COPY --from=build /home/app/dist .

# Copy custom Nginx configuration (optional but recommended)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for serving the app
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
