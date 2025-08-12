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
```
 resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "subnet_1_association" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "subnet_2_association" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "subnet_3_association" {
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.main.id
}

resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-south-1c"
  map_public_ip_on_launch = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.31"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = aws_vpc.main.id
  subnet_ids               = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]
  control_plane_subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]

  eks_managed_node_groups = {
    green = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["m5.xlarge"]

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }
} 

```
Step 3b: Create AWS Provider.tf file and Backend.tf
<img width="851" height="771" alt="image" src="https://github.com/user-attachments/assets/41e958ae-e871-4450-8661-b4454da71a53" />


<img width="824" height="264" alt="image" src="https://github.com/user-attachments/assets/d65d838f-3776-4d82-ae7d-4e78f9268c2d" />

# Configure Github Secrets
<img width="800" height="695" alt="image" src="https://github.com/user-attachments/assets/7e7baff1-9803-44b1-babc-08ed16ed034c" />
<img width="858" height="301" alt="image" src="https://github.com/user-attachments/assets/ff80391d-58ab-43a8-9d1b-dc34b869a18a" />#

# Step 4: Create GitHub Actions Workflow
<img width="848" height="828" alt="image" src="https://github.com/user-attachments/assets/392ac9e1-6406-463a-954b-8a078150555d" />
