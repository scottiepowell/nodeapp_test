# Use an official Node.js runtime as the base image
FROM arm64v8/node:16.20.0

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json before other files
# Utilize Docker cache to save re-installing dependencies if unchanged
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the current directory contents into the container
COPY . .

# Make the app's port available to the outside world
EXPOSE 4000

# Define the command to run the app
CMD [ "node", "index.js" ]
