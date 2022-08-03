#!/bin/bash
cd terraform

resources=$(terraform state list)
IFS='\n'

read -ra ADDR <<<"$resources"

for i in "${ADDR[@]}";
do
  echo "bla bla $i"
done

terraform state show aws_instance.tf_test_ec2
