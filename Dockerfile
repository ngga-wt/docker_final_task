# Use the official Alpine Linux image as the base image
FROM alpine:latest

# Install git and curl (or wget) to enable downloading from GitHub
RUN apk update && apk --no-cache add git curl python3

# Set the working directory inside the container
WORKDIR /app

# Download entrypoint.py file from github
RUN curl -O -L https://github.com/ngga-wt/docker_final_task/blob/main/entrypoint.py

# Copy local files into the container
COPY . /app
RUN chmod +x ./entrypoint.py

# Define the command to run when the container starts
CMD ["python3", "entrypoint.py"]
