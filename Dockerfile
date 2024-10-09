# Use an official Python runtime as the base image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the application code
COPY . /app

# Expose the application port
EXPOSE 8000

# Start the server
CMD ["python", "server.py"]