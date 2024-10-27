# Containers

## Podman vs Docker
I had a lot of problems trying to get docker to work but pobman just worked with little to now messing around so podman has been choosen as the default container runner.

outside of the `podmanNvidia.nix` there are packages that have to be installed in `networking.nix`. Im unsure if they are actually reqiured as I havent verified personaly but everything is working for now and it was specified in the guide.

# LLM Docker Setup

## Identify GPU's

```bash
nvidia-smi --query-gpu=index,name --format=csv

# Response
index, name
0, NVIDIA GeForce GTX 1650 Ti
1, NVIDIA GeForce RTX 3090
```
## Run container with gpu command General form

```bash
docker run --device nvidia.com/gpu=1 <your-image>
```

## Network Commands

This network allows the containers to communicate using their container names.

```bash
# Create a custom Docker network named 'ai'
docker network create <networkName>

## View networks
docker network ls

## Remove  network
docker network rm <networkName>
```

---


## **Step 2: Run the Containers**

### **Run the `ollama` Container**

# Run the 'ollama' container
```bash
podman run --d \
  --name ollama \
  --network=host \
  -p 5000:11434 \
  -v "/home/nathan/Docker/ollama:/root/.ollama" \
  --device nvidia.com/gpu=1 \
  ollama/ollama

podman run --d \
  --name open-webui \
  --network=host \
  -p 5001:8080 \
  -e PIPELINES_URL="http://pipelines:5002" \
  -e OLLAMA_URL="http://host.docker.internal:5000" \
  ghcr.io/open-webui/open-webui:main

podman run --d \
  --name pipelines \
  --network openai_network \
  -p 5002:9099 \
  -v pipelines:/app/pipelines \
  ghcr.io/open-webui/pipelines:main
```

### **Run the `pipelines` Container**

```bash
# Run the 'pipelines' container
docker run -d \
  --name pipelines \
  --network openai_network \
  -p 5002:9099 \
  -v pipelines:/app/pipelines \
  ghcr.io/open-webui/pipelines:main

# Run the 'pipelines' container
# Use the 'openai_network' network
# Expose port 5002 on the host and the container
# Mount the volume 'pipelines' to the /app/pipelines directory in the container
# Use the 'ghcr.io/open-webui/pipelines:main' image
```

### **Run the `open-webui` Container**

Set environment variables so `open-webui` can communicate with `ollama` and `pipelines`.

```bash
# Run the 'open-webui' container
docker run -d \
  --name open-webui \
  --network=host \
  -p 5001:8080 \
  -e PIPELINES_URL="http://pipelines:5002" \
  -e OLLAMA_URL="http://ollama:11434" \
  ghcr.io/open-webui/open-webui:main



# Run the 'open-webui' container
# Connect to the custom 'openai_network' network
# Map port 5001 on the container to port 5001 on the host
# Set the 'PIPELINES_URL' environment variable to "http://pipelines:5002"
# Set the 'OLLAMA_URL' environment variable to "http://ollama:11434"
# Use the 'ghcr.io/open-webui/open-webui:main' image
```

---

## **Step 3: Verify the Setup**

### **Check Running Containers**

```bash
# List all running containers
docker ps
```

You should see `ollama`, `pipelines`, and `open-webui` containers running.

### **Access Open-WebUI**

- Open your web browser and go to: `http://localhost:5001`

---



---

## **Troubleshooting**

### **Check Container Logs**

```bash
# View logs for a container (replace 'container_name' as needed)
docker logs container_name
```

### **Test Connectivity Between Containers**

```bash
# Open a shell inside the 'open-webui' container
docker exec -it open-webui sh

# Inside the container, test connectivity
ping pipelines    # Should reach the 'pipelines' container
ping ollama       # Should reach the 'ollama' container

# Exit the container shell
exit
```

---

## **Stopping and Cleaning Up**

### **Stop and Remove Containers**

```bash
# Stop the containers
docker stop ollama pipelines open-webui

# Remove the containers
docker rm ollama pipelines open-webui
```

### **Remove the Custom Docker Network**

```bash
# Remove the 'openai_network' network
docker network rm openai_network
```

---

## **Summary**

- **Create** a custom Docker network for inter-container communication.
- **Run** each container (`ollama`, `pipelines`, `open-webui`) connected to this network.
- **Verify** that the containers are running and accessible.
- **Troubleshoot** if necessary using logs and connectivity tests.
- **Clean up** by stopping and removing containers and the network when done.

---

Feel free to adjust the paths and commands according to your environment!