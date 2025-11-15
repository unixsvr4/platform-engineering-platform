#!/usr/bin/env bash
set -euo pipefail

# This script helps bootstrap a Kubernetes cluster for the Platform Engineering Platform.
# It can either create a local K3s cluster using k3d or guide you to the
# cloud-specific instructions for provisioning EKS, GKE, or AKS.

# --- Configuration ---
CLUSTER_NAME="platform-engineering-demo"

# --- Helper Functions ---
usage() {
  echo "Usage: $0 --provider <provider>"
  echo
  echo "Providers:"
  echo "  local   - Create a local K3s cluster using k3d."
  echo "  aws     - Guide to EKS provisioning instructions."
  echo "  gcp     - Guide to GKE provisioning instructions."
  echo "  azure   - Guide to AKS provisioning instructions."
  exit 1
}

# --- Main Logic ---
PROVIDER=""
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --provider) PROVIDER="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; usage ;;
  esac
  shift
done

if [ -z "$PROVIDER" ]; then
  echo "Error: --provider is a required argument."
  usage
fi

case "$PROVIDER" in
  local)
    echo "🚀 Bootstrapping a local K3s cluster..."
    if ! command -v k3d &> /dev/null; then
      echo "❌ k3d is not installed. Please install it to continue."
      echo "   Instructions: https://k3d.io/v5.6.0/#installation"
      exit 1
    fi

    if k3d cluster get "$CLUSTER_NAME" &> /dev/null; then
      echo "✅ Cluster '$CLUSTER_NAME' already exists."
    else
      echo "🔧 Creating k3d cluster '$CLUSTER_NAME'..."
      k3d cluster create "$CLUSTER_NAME" --port "8081:80@loadbalancer" --k3s-arg "--disable=traefik@server:0"
      echo "✅ Cluster '$CLUSTER_NAME' created successfully."
    fi

    echo
    echo "🎉 Your local Kubernetes cluster is ready!"
    echo "   You can now use kubectl to interact with it."
    echo "   For example: kubectl get nodes"
    ;;
  aws)
    echo "📄 For AWS, please follow the instructions in 'docs/aws-setup.md' to provision an EKS cluster."
    ;;
  gcp)
    echo "📄 For GCP, please follow the instructions in 'docs/gcp-setup.md' to provision a GKE cluster."
    ;;
  azure)
    echo "📄 For Azure, please follow the instructions in 'docs/azure-setup.md' to provision an AKS cluster."
    ;;
  *)
    echo "Error: Invalid provider '$PROVIDER'."
    usage
    ;;
esac
