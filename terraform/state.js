const { exec } = require('child_process');

exec('terraform state list', (error, stdout, stderr) => {
  console.log(stdout.trim().split('\n').map((resource) => resource.trim()));
});

// # terraform state show aws_instance.tf_test_ec2
