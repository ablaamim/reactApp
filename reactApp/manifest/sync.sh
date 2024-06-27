#!/bin/bash


argocd_password=$(kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo $argocd_password


argocd login 10.50.29.222:30010 --username admin --password $argocd_password --insecure


sleep 5

# Create a new ArgoCD application
argocd app create reactapp --repo 'https://github.com/ablaamim/reactApp.git' --path 'reactApp/manifest' --dest-namespace 'applications' --dest-server 'https://kubernetes.default.svc' --grpc-web

sleep 5

# Retrieve details of the newly created application
argocd app get reactapp --grpc-web
# Sleep for 5 seconds to prevent potential connection issues
sleep 5

# Synchronize the application state with the git repository
argocd app sync reactapp --grpc-web
# Sleep for 5 seconds to prevent potential connection issues
sleep 5

# Set the application to automatically synchronize changes
argocd app set reactapp --sync-policy automated --grpc-web
# Sleep for 5 seconds to prevent potential connection issues
sleep 5

# Set the application to automatically prune resources that are removed from the git repository
argocd app set reactapp --auto-prune --allow-empty --grpc-web
# Sleep for 5 seconds to prevent potential connection issues
sleep 5

# Retrieve details of the application again to confirm the settings
argocd app get reactapp --grpc-web

# Print final messages indicating successful installation and setup
echo "Docker, k3d, kubectl, and ArgoCD have been installed successfully."
echo "Deployment configuration has been applied to the dev namespace using ArgoCD."
echo "ArgoCD application synchronization has been triggered."
echo "Please log out and log back in to apply Docker group changes."
