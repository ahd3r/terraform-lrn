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
  private_dns_hostname_type_on_launch = "ip-name"
}

# already attached
resource "aws_internet_gateway" "tf_ig" {
  vpc_id = aws_vpc.tf_vpc.id
}

resource "aws_default_route_table" "tf_rt" {
  default_route_table_id = aws_vpc.tf_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_ig.id
  }
}

resource "aws_security_group" "tf_sg" {
  name = "sg"
  description = "Open server ports"
  vpc_id = aws_vpc.tf_vpc.id

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "tf_key_pair" {
  key_name   = "tf_key_pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8y4NucoBq04rwNkIUu4krEJ4zgRDpjNBueEh2S6coTcYS3++ZnCOJic+STQEXutezD6I82L6mP4FozUNA1l0do6m+yEsTHI8ssvy5wgT+XmP3m36tr0zA9l+albEg+aEZVpmyUl6gN/D6QQavO1BscYk3YqnVahgGt35UsOkTrzH9M9uhI5eokwLMVi3gYlUc2oknPKYkgW/92WljKTmZbGCtUUPyf7OdqW4x8dS6c4qp2oiT2Tg7wreDKPHx4myLnqb6INNlUGzszS2PeOsq9KukY443oUmVAsLZjpLX3GOOMljkwa9KxSubZhkkU/8QghmAtB8mMVEeqdSIWklLo9cj/TdqIvposeVGU1uL8+z3wUGuK0wDk84HERpH2z/Lqaber48l3vnFBP2YRaLIQh98A3f3KPfyGv9YEne6dBBTX9+I3gsj0KGU62o8OMxh0UsrcRL85eA5R0CGqbqKu+VrxpsU9Re7vNxxK4GBrNKyHkvcYN0+earEGhb0+8k= ander@ander-Inspiron-5584"
}

# resource "aws_instance" "tf_test_ec2" {
#   ami = "ami-0cff7528ff583bf9a"
#   instance_type = "t2.micro"
#   disable_api_termination = true
#   vpc_security_group_ids = [aws_security_group.tf_sg.id]
#   key_name = "tf_key_pair"
#   subnet_id = aws_subnet.tf_subnet.id

#   user_data = <<-EOF
#   #! /bin/bash
#   mkdir ~/app
#   sudo yum update -y
#   sudo yum install git -y
#   git config --global credential.helper store
#   sudo yum update -y
#   sudo amazon-linux-extras install docker
#   sudo service docker start
#   sudo usermod -a -G docker ec2-user
#   sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
#   sudo chmod +x /usr/local/bin/docker-compose
#   sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
#   EOF
# }
