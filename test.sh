# #!/bin/bash
cd terraform

resources=$(terraform state list)
echo $(terraform state list)
echo 1 $resources
echo 2 "$resources"
echo 3 "${resources}"
IFS=$'\n' read -r -a array <<< "${resources}"

for i in "${array[@]}";
do
  echo "bla bla $i"
done

terraform state show aws_instance.tf_test_ec2
