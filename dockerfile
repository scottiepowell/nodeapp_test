# Use an official Node.js runtime as the base image for the builder
FROM arm64v8/node:16.20.0 AS builder

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json before other files
# Utilize Docker cache to save re-installing dependencies if unchanged
COPY package*.json ./

# Install ALL dependencies, including 'devDependencies'
RUN npm install

# Copy the current directory contents into the container
COPY . .

# Build the app using your build system
# This is a placeholder, replace with your actual build command
RUN npm run build

# --- 

# Now, define the runtime image
FROM arm64v8/node:16.20.0

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json before other files
# Utilize Docker cache to save re-installing dependencies if unchanged
COPY package*.json ./

# Install ONLY production dependencies
RUN npm install --only=production

# Copy the built application from the builder stage
COPY --from=builder /usr/src/app/dist ./dist

# Make the app's port available to the outside world
EXPOSE 4000

# Define the command to run the app
CMD [ "node", "dist/index.js" ]
