# Kubernetes Hello World with Minikube on Kali Linux

## Overview

This project guides you through deploying a simple "Hello World" Node.js application to a Kubernetes environment using Minikube on a Kali Linux system. Our goal is to provide a comprehensive, hands-on experience with core Kubernetes concepts, from containerization to scaling and updates, all within a local, free-to-use setup. This `README.md` has been updated to reflect current best practices and technologies.

### Why Minikube on Kali?

While the original lab used Google Kubernetes Engine, we're adapting it for Minikube to enable local, cost-free learning and development. Kali Linux provides a robust environment for system-level work, making it an excellent platform for this kind of hands-on infrastructure learning.

## What You'll Learn

* Create a Node.js server.
* Create a Docker container image.
* Set up and manage a local Kubernetes cluster using Minikube.
* Deploy applications using Kubernetes Pods and Deployments.
* Expose your services for external access.
* Scale up your applications.
* Perform rolling updates to your services without downtime.

## Prerequisites

* A Kali Linux environment (virtual machine or physical installation).
* Familiarity with basic Linux command-line operations.
* Basic understanding of Node.js (not strictly required, but helpful).
* Understanding of standard Linux text editors (e.g., `vim`, `nano`, `emacs`).
* Internet connection for downloading dependencies and Docker images.

## Setup and Requirements

### 1. Update Your System

Ensure your Kali Linux system is fully updated:

```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Install Docker

Docker is essential for building and managing our container images.

```bash
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
newgrp docker # Apply group changes immediately
```

Verify Docker installation:

```bash
docker --version
```

### 3. Install Kubectl

`kubectl` is the command-line tool for interacting with Kubernetes clusters.

```bash
sudo apt install curl -y
curl -LO "[https://dl.k8s.io/release/$(curl](https://dl.k8s.io/release/$(curl) -L -s [https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl](https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl)"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

### 4. Install Minikube

Minikube allows us to run a single-node Kubernetes cluster locally. We'll use the `docker` driver for simplicity.

```bash
curl -LO [https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64](https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64)
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start --driver=docker
```

This command will download the necessary components and start your local Minikube cluster. This may take a few minutes.

Verify Minikube status:

```bash
minikube status
```

You should see output indicating that `host`, `kubelet`, and `apiserver` are `Running` and `kubeconfig` is `Configured`.

## Lab Activities

### Task 1. Create Your Node.js Application

First, we'll write a simple Node.js server that our Kubernetes cluster will host.

1. Create a file named `server.js`:

   ```bash
   nano server.js
   ```

2. Add the following content to `server.js`:

   ```javascript
   var http = require('http');
   var handleRequest = function(request, response) {
     response.writeHead(200);
     response.end("Hello World!");
   }
   var www = http.createServer(handleRequest);
   www.listen(8080);
   ```

3. Save the file (Ctrl+X, Y, Enter for Nano).

4. (Optional) Test the Node.js server locally:

   ```bash
   node server.js
   ```

   Open another terminal and use `curl` to test it:

   ```bash
   curl http://localhost:8080
   ```

   You should see "Hello World!". Press `Ctrl+C` in the terminal running `node server.js` to stop it before proceeding.

### Task 2. Create a Docker Container Image

Next, we'll package our Node.js application into a Docker container image.

1. Create a file named `Dockerfile`:

   ```bash
   nano Dockerfile
   ```

2. Add the following content to `Dockerfile`:

   ```dockerfile
   FROM node:18-alpine # Using a modern, lightweight Node.js image
   EXPOSE 8080
   COPY server.js .
   CMD ["node", "server.js"]
   ```

3. Save the file.

4. Build the Docker image. We'll tag it as `hello-node:v1`.

   ```bash
   docker build -t hello-node:v1 .
   ```

   This will take some time as Docker downloads the base image.

5. (Optional) Test the Docker image locally:

   ```bash
   docker run -d -p 8080:8080 hello-node:v1
   ```

   Then, in another terminal:

   ```bash
   curl http://localhost:8080
   ```

   You should see "Hello World!". To stop the container, first find its ID:

   ```bash
   docker ps
   ```

   Then stop it, replacing `[CONTAINER ID]` with your container's ID:

   ```bash
   docker stop [CONTAINER ID]
   ```

### Task 3. Deploy Your Application to Minikube

Now, let's deploy our containerized application to our Minikube cluster.

1. Verify `kubectl` is configured to use Minikube:

   ```bash
   kubectl config current-context
   ```

   It should show `minikube`. If not, run `kubectl config use-context minikube`.

2. Create a Kubernetes Deployment for our application:

   ```bash
   kubectl create deployment hello-node --image=hello-node:v1
   ```

   *Note: Since we're using Minikube with the Docker driver, the `hello-node:v1` image is already available in Docker's local image cache, which Minikube can access directly. We don't need a remote registry like Artifact Registry for this local setup.*

3. Check the status of your deployment:

   ```bash
   kubectl get deployments
   ```

   You should see `hello-node` with `1/1` ready.

4. Check the Pods managed by your deployment:

   ```bash
   kubectl get pods
   ```

   You should see a pod named `hello-node-...` in a `Running` status.

### Task 4. Allow External Traffic (Expose the Service)

By default, our Pod is only accessible within the Kubernetes cluster. To reach it from our local machine, we need to expose it as a Kubernetes Service.

1. Expose the deployment as a LoadBalancer type service. Minikube will simulate a LoadBalancer for us.

   ```bash
   kubectl expose deployment hello-node --type=LoadBalancer --port=8080
   ```

2. Get the URL for your service. This command will provide the external access URL.

   ```bash
   minikube service hello-node --url
   ```

   Copy this URL (e.g., `http://127.0.0.1:XXXXX`) and paste it into your web browser or use `curl` from your terminal:

   ```bash
   curl <YOUR_SERVICE_URL>
   ```

   You should see "Hello World!".

### Task 5. Scale Up Your Service

One of Kubernetes' most powerful features is its ability to easily scale applications.

1. Scale your `hello-node` deployment to 4 replicas:

   ```bash
   kubectl scale deployment hello-node --replicas=4
   ```

2. Verify the scaling:

   ```bash
   kubectl get deployments
   ```

   You should see `hello-node` with `4/4` ready.

3. Observe the new Pods:

   ```bash
   kubectl get pods
   ```

   You'll now see four `hello-node-...` pods running. Kubernetes ensures that your declared number of instances are always running.

### Task 6. Roll Out an Upgrade to Your Service

Let's simulate an application update.

1. Modify `server.js` to change the response message.

   ```bash
   nano server.js
   ```

2. Change the `response.end` line to:

   ```javascript
   response.end("Hello Kubernetes World!");
   ```

3. Save the file.

4. Build a new Docker image, tagging it as `hello-node:v2`:

   ```bash
   docker build -t hello-node:v2 .
   ```

5. Update your Kubernetes deployment to use the new `v2` image. We'll use `kubectl set image` for a cleaner update.

   ```bash
   kubectl set image deployment/hello-node hello-node=hello-node:v2
   ```

   This command tells Kubernetes to perform a rolling update, gradually replacing the old `v1` pods with new `v2` pods, ensuring no downtime.

6. Watch the rollout status:

   ```bash
   kubectl rollout status deployment/hello-node
   ```

   Wait until it reports "deployment "hello-node" successfully rolled out."

7. Verify the new version:

   ```bash
   curl $(minikube service hello-node --url)
   ```

   You should now see "Hello Kubernetes World!".

   You can also check the pods to see the new image:

   ```bash
   kubectl get pods -o wide
   ```

   Look at the `IMAGE` column, and you'll see `hello-node:v2` for the new pods.

## Cleanup

When you're finished, you can stop or delete your Minikube cluster:

### Stop Minikube (to save resources, but keep the cluster state)

```bash
minikube stop
```

### Delete Minikube (to completely remove the cluster and free disk space)

```bash
minikube delete
```

## Next Steps

Now that you've mastered the basics, here are some ideas for further exploration:

* Experiment with different `kubectl` commands (e.g., `kubectl describe`, `kubectl logs`).
* Explore Kubernetes YAML definitions for Deployments and Services.
* Containerize a different application (e.g., a simple Python Flask app).
* Learn about persistent storage in Kubernetes.
* Start integrating bash scripts for automated setup, and then, as you planned, build out Ansible playbooks!
