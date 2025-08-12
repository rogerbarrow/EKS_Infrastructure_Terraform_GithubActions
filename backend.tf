terraform {
  backend "s3" {
    bucket = "cicd-terraform-eks-b
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
