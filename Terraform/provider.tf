terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }

  backend "s3" {
    bucket = "tf-state-venkat"
    key    = "statefiles/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform"            #create a dynamodb table with primary key/ partition key as LockID
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}