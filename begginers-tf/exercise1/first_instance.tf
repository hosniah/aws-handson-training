terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

}

# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}

resource "aws_instance" "intro" {
  ami                    = "ami-0b5eea76982371e91"
  instance_type          = "t2.micro"
  key_name               = "ahmed-key"
  vpc_security_group_ids = ["sg-037e6857bfcfe6763"]
  tags = {
    Name    = "lambdaInstance"
  }
}
