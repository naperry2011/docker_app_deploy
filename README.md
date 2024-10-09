# docker_app_deploy
Containerize and Deploy Applications Using Docker

**Exercise 2: Containerize and Deploy Applications Using Docker**

**Goal**: Build a Docker container for a sample web application and push it to a container registry such as Docker Hub or Amazon ECR.

### Step-by-Step Guide:

#### Step 1: Set Up Your Environment
1. **Install Docker**: Ensure Docker is installed on your local machine. You can download it from [Docker's official site](https://docs.docker.com/get-docker/).
2. **Verify Installation**: Verify Docker installation by running:
   ```bash
   docker --version
   ```
   Make sure Docker is properly installed and running.

#### Step 2: Create a Sample Web Application
1. **Create a Project Directory**: Create a new directory for your sample web application.
   ```bash
   mkdir docker_app_deploy && cd docker_app_deploy
   ```
2. **Write a Simple Web Application**: Create a simple Python web server.


   **For Python**:
   - Create a `server.py` file with the following content:
     ```python
     from http.server import SimpleHTTPRequestHandler, HTTPServer

     port = 8000
     handler = SimpleHTTPRequestHandler
     server = HTTPServer(("0.0.0.0", port), handler)

     print(f"Server running on port {port}")
     server.serve_forever()
     ```

#### Step 3: Write a Dockerfile
1. **Create a Dockerfile**: In the same directory as your web application, create a file named `Dockerfile`.


   **For Python**:
   ```dockerfile
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
   ```

#### Step 4: Build and Run the Docker Image
1. **Build the Docker Image**: Run the following command to build your Docker image:
   ```bash
   docker build -t docker_app_deploy .
   ```
   This command will create a Docker image named `docker_app_deploy`.

2. **Run the Docker Container**: Use the following command to run the Docker container:
   ```bash
   docker run -p 3000:3000 sample-web-app
   ```
   Replace `3000` with `8000` if you're using the Python example. You should be able to access your application by navigating to `http://localhost:3000` or `http://localhost:8000` in your web browser.

#### Step 5: Push the Docker Image to Amazon ECR
1. **Create an ECR Repository**: Use the AWS CLI to create an Amazon ECR repository.
   ```bash
   aws ecr create-repository --repository-name docker_app_deploy
   ```

2. **Authenticate Docker to ECR**: Get the authentication token for Docker to access Amazon ECR and authenticate Docker.
   ```bash
   aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
   ```
   Replace `<your-region>` with your AWS region and `<your-account-id>` with your AWS account ID.

3. **Tag the Docker Image**: Tag your Docker image with the ECR repository URI.
   ```bash
   docker tag docker_app_deploy <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/docker_app_deploy:latest
   ```

4. **Push the Image**: Push the image to Amazon ECR.
   ```bash
   docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/docker_app_deploy:latest
   ```

#### Step 6: Clean Up Docker Resources
- To remove the Docker container:
  ```bash
  docker rm -f <container-id>
  ```
- To remove the Docker image:
  ```bash
  docker rmi sample-web-app
  ```



