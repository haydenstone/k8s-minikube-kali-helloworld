# Using a modern, lightweight Node.js image
FROM node:18-alpine
EXPOSE 8080
# Copy package.json and package-lock.json (even if empty for this app, good practice for future projects)
COPY package*.json ./
# For this simple "Hello World" app, no external npm dependencies are needed,
# so we can skip the 'npm install' step which was causing an error.
# If your Node.js app later requires dependencies, you would uncomment/add:
# RUN npm install --production
COPY server.js .
CMD ["node", "server.js"]