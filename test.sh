#!/bin/bash
cd terraform

resources=$(terraform state list)
echo without quote
echo ${resources}
echo with quote
echo "${resources}"
terraform state show aws_instance.tf_test_ec2
