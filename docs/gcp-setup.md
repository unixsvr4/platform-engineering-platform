# Provisioning a GKE Cluster for the Platform Engineering Platform

This document provides instructions on how to provision a Google Kubernetes Engine (GKE) cluster for the Platform Engineering Platform.

> **Note:** These are placeholder instructions. You will need to replace them with your actual GKE provisioning steps.

## Prerequisites

*   A Google Cloud Platform (GCP) project.
*   `gcloud` CLI installed and configured.
*   `kubectl` installed.

## Steps

1.  **Create a GKE cluster:**
    Use the `gcloud` CLI to create a new GKE cluster.

    ```bash
    gcloud container clusters create platform-engineering-demo \
      --zone us-central1-c \
      --num-nodes 2 \
      --machine-type n1-standard-2
    ```

2.  **Configure `kubectl`:**
    Once the cluster is created, configure `kubectl` to use it:

    ```bash
    gcloud container clusters get-credentials platform-engineering-demo --zone us-central1-c
    ```

    You can verify this by running:

    ```bash
    kubectl get nodes
    ```

3.  **Next Steps:**
    Once the cluster is running, you can proceed with deploying the platform components to it.

