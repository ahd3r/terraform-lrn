variable "access_key" {
  description = "AWS access key"
  type = string
}

variable "secret_key" {
  description = "AWS secret key"
  type = string
}



provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}



resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "tf_subnet" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = true
  enable_resource_name_dns_a_record_on_launch = true
  # enable_resource_name_dns_aaaa_record_on_launch = true
  private_dns_hostname_type_on_launch = "ip-name" # resource-name
}
