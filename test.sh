#!/bin/bash
cd terraform

resources=$(terraform state list)
resources_string="${resources}"
echo $resources_string
echo "${resources_string}"
# IFS=$'\n' read -r -a array <<< "${resources}"

# for i in "${array[@]}";
# do
#   echo "bla bla $i"
# done

# terraform state show aws_instance.tf_test_ec2
