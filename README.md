# EKS_Infrastructure_Terraform_GithubActions
EKS_Infrastructure_Terraform_GithubActions

GitOps ArgoCD Implementation: Automate Infrastructure Creation with Terraform & GitHub Actions, and Application Deployment on EKS Cluster

# Overview
This guide will help you set up an automated GitOps pipeline:

Automate Infrastructure: Use Terraform and GitHub Actions to provision an EKS cluster.
Automate Application Deployment: Use ArgoCD to monitor the application repository and deploy updates to the EKS cluster automatically.

# Pre-requisites
GitHub account to create repositories.

AWS account with permissions to create EKS resources.

AWS CLI installed and configured on your local machine.

kubectl installed for Kubernetes cluster management.

# Step 1: Create GitHub Repositories and Clone it Locally

<img width="943" height="519" alt="image" src="https://github.com/user-attachments/assets/283836c6-3be3-46f5-979c-0a6cd7c9d82d" />

# Step 2.
Create and Configure Terraform for EKS Setup
