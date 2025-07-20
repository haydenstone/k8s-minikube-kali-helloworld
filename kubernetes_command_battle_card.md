# Kubernetes Command Battle Card

This battle card provides a quick reference for essential `kubectl` commands, designed for rapid lookup during your Kubernetes journey.

---

## I. General Cluster Information

| Command Syntax | Description |
|---|---|
| `kubectl cluster-info` | Displays information about the cluster master and services. |
| `kubectl config view` | Shows the current `kubeconfig` context and cluster details. |
| `kubectl version` | Prints the client and server versions of Kubernetes. |

---

## II. Resource Management (Get, Describe, Delete)

| Command Syntax | Description |
|---|---|
| `kubectl get <resource_type>` | Lists resources of a specific type (e.g., `pods`, `deployments`, `services`). |
| `kubectl get pods -o wide` | Lists pods with additional details like Node IP and internal IP (may not show image on all setups). |
| `kubectl describe <resource_type>/<name>` | Shows detailed information about a specific resource. |
| `kubectl delete <resource_type>/<name>` | Deletes a specific resource (e.g., `deployment/hello-node`). |
| `kubectl delete all --all` | **(USE WITH CAUTION!)** Deletes all resources in the current namespace. |

---

## III. Deployments

| Command Syntax | Description |
|---|---|
| `kubectl create deployment <name> --image=<image>` | Creates a new Deployment with the specified image. |
| `kubectl get deployments` | Lists all Deployments. |
| `kubectl scale deployment <name> --replicas=<num>` | Scales a Deployment to the specified number of replicas. |
| `kubectl set image deployment/<name> <container>=<new_image>` | Updates the image of a container within a Deployment (initiates a rolling update). |
| `kubectl rollout status deployment/<name>` | Monitors the status of a rolling update for a Deployment. |
| `kubectl rollout undo deployment/<name>` | Rolls back a Deployment to its previous version. |
| `kubectl rollout history deployment/<name>` | Shows the revision history of a Deployment. |

---

## IV. Services

| Command Syntax | Description |
|---|---|
| `kubectl expose deployment <name> --type=<type> --port=<port>` | Exposes a Deployment as a Service (e.g., `LoadBalancer`, `NodePort`, `ClusterIP`). |
| `kubectl get services` | Lists all Services in the cluster. |
| `minikube service <service_name> --url` | (Minikube specific) Gets the external URL for a Service exposed as LoadBalancer. |

---

## V. Pods

| Command Syntax | Description |
|---|---|
| `kubectl get pods` | Lists all Pods. |
| `kubectl describe pod <pod_name>` | Shows detailed information about a specific Pod, including container images. |
| `kubectl logs <pod_name>` | Displays the logs from a container in a Pod. |
| `kubectl exec -it <pod_name> -- <command>` | Executes a command inside a running container within a Pod. |

---

## VI. Troubleshooting & Debugging

| Command Syntax | Description |
|---|---|
| `kubectl get events` | Lists recent events in the cluster, useful for diagnosing issues. |
| `kubectl top pods` | Shows CPU/memory usage for Pods (requires Metrics Server). |
| `kubectl top nodes` | Shows CPU/memory usage for Nodes (requires Metrics Server). |

---

## VII. Minikube Specific Commands

| Command Syntax | Description |
|---|---|
| `minikube start --driver=<driver>` | Starts the Minikube cluster using a specified driver (e.g., `docker`). |
| `minikube status` | Checks the status of the Minikube cluster. |
| `minikube stop` | Stops the Minikube cluster (preserves state). |
| `minikube delete` | Deletes the Minikube cluster (removes all state and resources). |
| `minikube dashboard` | Opens the Kubernetes Dashboard in your browser. |
| `minikube ssh` | Connects to the Minikube VM via SSH. |

---