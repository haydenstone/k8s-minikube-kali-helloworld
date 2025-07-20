# Kubernetes Command Battle Card

This battle card provides a quick reference for essential `kubectl` commands, designed for rapid lookup during your Kubernetes journey.

## Table of Contents

* [I. General Cluster Information](#i-general-cluster-information)
    * [`kubectl cluster-info`](#kubectl-cluster-info)
    * [`kubectl config view`](#kubectl-config-view)
    * [`kubectl version`](#kubectl-version)
* [II. Resource Management (Get, Describe, Delete)](#ii-resource-management-get-describe-delete)
    * [`kubectl get <resource_type>`](#kubectl-get-resource_type)
    * [`kubectl get pods -o wide`](#kubectl-get-pods-o-wide)
    * [`kubectl describe <resource_type>/<name>`](#kubectl-describe-resource_type-name)
    * [`kubectl delete <resource_type>/<name>`](#kubectl-delete-resource_type-name)
    * [`kubectl delete all --all`](#kubectl-delete-all-all)
* [III. Deployments](#iii-deployments)
    * [`kubectl create deployment <name> --image=<image>`](#kubectl-create-deployment-name-image)
    * [`kubectl get deployments`](#kubectl-get-deployments)
    * [`kubectl scale deployment <name> --replicas=<num>`](#kubectl-scale-deployment-name-replicas-num)
    * [`kubectl set image deployment/<name> <container>=<new_image>`](#kubectl-set-image-deployment-name-container-new_image)
    * [`kubectl rollout status deployment/<name>`](#kubectl-rollout-status-deployment-name)
    * [`kubectl rollout undo deployment/<name>`](#kubectl-rollout-undo-deployment-name)
    * [`kubectl rollout history deployment/<name>`](#kubectl-rollout-history-deployment-name)
* [IV. Services](#iv-services)
    * [`kubectl expose deployment <name> --type=<type> --port=<port>`](#kubectl-expose-deployment-name-type-port)
    * [`kubectl get services`](#kubectl-get-services)
    * [`minikube service <service_name> --url`](#minikube-service-service_name-url)
* [V. Pods](#v-pods)
    * [`kubectl get pods`](#kubectl-get-pods)
    * [`kubectl describe pod <pod_name>`](#kubectl-describe-pod-pod_name)
    * [`kubectl logs <pod_name>`](#kubectl-logs-pod_name)
    * [`kubectl exec -it <pod_name> -- <command>`](#kubectl-exec-it-pod_name-command)
* [VI. Troubleshooting & Debugging](#vi-troubleshooting-debugging)
    * [`kubectl get events`](#kubectl-get-events)
    * [`kubectl top pods`](#kubectl-top-pods)
    * [`kubectl top nodes`](#kubectl-top-nodes)
* [VII. Minikube Specific Commands](#vii-minikube-specific-commands)
    * [`minikube start --driver=<driver>`](#minikube-start-driver)
    * [`minikube status`](#minikube-status)
    * [`minikube stop`](#minikube-stop)
    * [`minikube delete`](#minikube-delete)
    * [`minikube dashboard`](#minikube-dashboard)
    * [`minikube ssh`](#minikube-ssh)

---

## I. General Cluster Information

| Command Syntax | Description |
|---|---|
| <a id="kubectl-cluster-info"></a>`kubectl cluster-info` | Displays information about the cluster master and services. |
| <a id="kubectl-config-view"></a>`kubectl config view` | Shows the current `kubeconfig` context and cluster details. |
| <a id="kubectl-version"></a>`kubectl version` | Prints the client and server versions of Kubernetes. |

---

## II. Resource Management (Get, Describe, Delete)

| Command Syntax | Description |
|---|---|
| <a id="kubectl-get-resource_type"></a>`kubectl get <resource_type>` | Lists resources of a specific type (e.g., `pods`, `deployments`, `services`). |
| <a id="kubectl-get-pods-o-wide"></a>`kubectl get pods -o wide` | Lists pods with additional details like Node IP and internal IP (may not show image on all setups). |
| <a id="kubectl-describe-resource_type-name"></a>`kubectl describe <resource_type>/<name>` | Shows detailed information about a specific resource. |
| <a id="kubectl-delete-resource_type-name"></a>`kubectl delete <resource_type>/<name>` | Deletes a specific resource (e.g., `deployment/hello-node`). |
| <a id="kubectl-delete-all-all"></a>`kubectl delete all --all` | **(USE WITH CAUTION!)** Deletes all resources in the current namespace. |

---

## III. Deployments

| Command Syntax | Description |
|---|---|
| <a id="kubectl-create-deployment-name-image"></a>`kubectl create deployment <name> --image=<image>` | Creates a new Deployment with the specified image. |
| <a id="kubectl-get-deployments"></a>`kubectl get deployments` | Lists all Deployments. |
| <a id="kubectl-scale-deployment-name-replicas-num"></a>`kubectl scale deployment <name> --replicas=<num>` | Scales a Deployment to the specified number of replicas. |
| <a id="kubectl-set-image-deployment-name-container-new_image"></a>`kubectl set image deployment/<name> <container>=<new_image>` | Updates the image of a container within a Deployment (initiates a rolling update). |
| <a id="kubectl-rollout-status-deployment-name"></a>`kubectl rollout status deployment/<name>` | Monitors the status of a rolling update for a Deployment. |
| <a id="kubectl-rollout-undo-deployment-name"></a>`kubectl rollout undo deployment/<name>` | Rolls back a Deployment to its previous version. |
| <a id="kubectl-rollout-history-deployment-name"></a>`kubectl rollout history deployment/<name>` | Shows the revision history of a Deployment. |

---

## IV. Services

| Command Syntax | Description |
|---|---|
| <a id="kubectl-expose-deployment-name-type-port"></a>`kubectl expose deployment <name> --type=<type> --port=<port>` | Exposes a Deployment as a Service (e.g., `LoadBalancer`, `NodePort`, `ClusterIP`). |
| <a id="kubectl-get-services"></a>`kubectl get services` | Lists all Services in the cluster. |
| <a id="minikube-service-service_name-url"></a>`minikube service <service_name> --url` | (Minikube specific) Gets the external URL for a Service exposed as LoadBalancer. |

---

## V. Pods

| Command Syntax | Description |
|---|---|
| <a id="kubectl-get-pods"></a>`kubectl get pods` | Lists all Pods. |
| <a id="kubectl-describe-pod-pod_name"></a>`kubectl describe pod <pod_name>` | Shows detailed information about a specific Pod, including container images. |
| <a id="kubectl-logs-pod_name"></a>`kubectl logs <pod_name>` | Displays the logs from a container in a Pod. |
| <a id="kubectl-exec-it-pod_name-command"></a>`kubectl exec -it <pod_name> -- <command>` | Executes a command inside a running container within a Pod. |

---

## VI. Troubleshooting & Debugging

| Command Syntax | Description |
|---|---|
| <a id="kubectl-get-events"></a>`kubectl get events` | Lists recent events in the cluster, useful for diagnosing issues. |
| <a id="kubectl-top-pods"></a>`kubectl top pods` | Shows CPU/memory usage for Pods (requires Metrics Server). |
| <a id="kubectl-top-nodes"></a>`kubectl top nodes` | Shows CPU/memory usage for Nodes (requires Metrics Server). |

---

## VII. Minikube Specific Commands

| Command Syntax | Description |
|---|---|
| <a id="minikube-start-driver"></a>`minikube start --driver=<driver>` | Starts the Minikube cluster using a specified driver (e.g., `docker`). |
| <a id="minikube status"></a>`minikube status` | Checks the status of the Minikube cluster. |
| <a id="minikube-stop"></a>`minikube stop` | Stops the Minikube cluster (preserves state). |
| <a id="minikube-delete"></a>`minikube delete` | Deletes the Minikube cluster (removes all state and resources). |
| <a id="minikube-dashboard"></a>`minikube dashboard` | Opens the Kubernetes Dashboard in your browser. |
| <a id="minikube-ssh"></a>`minikube ssh` | Connects to the Minikube VM via SSH. |

---