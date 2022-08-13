const { exec } = require('child_process');

exec('terraform state list', (error, stdout, stderr) => {
  console.log('error', error);
  console.log('stdout', stdout);
  console.log('stderr', stderr);
});

// # terraform state show aws_instance.tf_test_ec2
