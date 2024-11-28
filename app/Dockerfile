# Use the official Nginx image as the base
FROM nginx:latest

# Remove the default Nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy your static assets to the Nginx directory
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY app.js /usr/share/nginx/html/

# Expose port 80 to the host
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
