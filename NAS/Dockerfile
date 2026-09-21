# Specify the base image
FROM julia:latest

# Copy the Julia script into the container
COPY hello.jl /app/

# Set the working directory
WORKDIR /app

# Run the Julia script
CMD ["julia", "hello.jl"]