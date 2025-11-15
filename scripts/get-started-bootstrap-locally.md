### Step-by-Step Guide to Demonstrate the Local K3s Cluster

This guide assumes you are in the root directory of your `platform-engineering-platform` project.

#### 1. Install Prerequisites

First, ensure you have `k3d` and `kubectl` installed. These tools are essential for managing your local K3s cluster.

*   **Install `k3d` (if not already installed):**
    `k3d` is a lightweight wrapper to run K3s (a lightweight Kubernetes distribution) in Docker.

    ```bash
    brew install k3d
    ```

*   **Install `kubectl` (if not already installed):**
    `kubectl` is the command-line tool for running commands against Kubernetes clusters.

    ```bash
    brew install kubectl
    ```

#### 2. Run the Bootstrap Script

Now, execute the `bootstrap-local.sh` script to create your local K3s cluster.

*   **Navigate to the project root:**
    ```bash
    cd platform-engineering-platform
    ```
*   **Execute the script:**
    ```bash
    ./scripts/bootstrap-local.sh --provider local
    ```
    **What to look for:**
    *   The script will first check if `k3d` is installed. If not, it will prompt you to install it.
    *   It will then check if a cluster named `platform-engineering-demo` already exists. If it does, it will inform you.
    *   If the cluster doesn't exist, `k3d` will proceed to create it. You'll see output indicating Docker containers being created and K3s starting up.
    *   Finally, you should see a message like "✅ Cluster 'platform-engineering-demo' created successfully." and "🎉 Your local Kubernetes cluster is ready!".

#### 3. Verify the Cluster (What to Look For)

After the script completes, `k3d` automatically configures `kubectl` to point to your new local cluster. You can verify its status:

*   **Check Kubernetes nodes:**
    ```bash
    kubectl get nodes
    ```
    **What to look for:**
    You should see output similar to this, indicating your K3s server node is ready:
    ```
    NAME                         STATUS   ROLES                  AGE   VERSION
    k3d-platform-engineering-demo-server-0   Ready    control-plane,master   2m    v1.27.4+k3s1
    ```

*   **Get cluster information:**
    ```bash
    kubectl cluster-info
    ```
    **What to look for:**
    This will show you the Kubernetes control plane's address and other service endpoints, confirming `kubectl` is connected to your local K3s cluster.

If you have any simple Kubernetes manifests (e.g., a basic Nginx deployment), you could even quickly deploy them to the local K3s cluster to show an application running:

```bash
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=LoadBalancer
kubectl get services
```
(Note: `k3d` maps port 8081 on your localhost to the LoadBalancer service, so you might access it via `localhost:8081`.)
