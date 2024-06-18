terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3"{
        bucket = "s3minikube"
        key="minikube"
        region = "us-east-1"
        dynamodb_table = "minikubeDydb"
    }
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
