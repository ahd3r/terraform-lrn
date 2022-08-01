variable "access_key" {
  description = "AWS access key"
  type = string
}

variable "secret_key" {
  description = "AWS secret key"
  type = string
}



provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}



resource "aws_vpc" "tf_vpc" {
}
