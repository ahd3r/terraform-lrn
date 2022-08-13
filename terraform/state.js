const { exec } = require('child_process');

exec('terraform state list', (error, stdout, stderr) => {
  const resources = stdout
    .trim()
    .split('\n')
    .map((resource) => resource.trim())
    .filter(Boolean)
    .filter((resource) => !resource.startsWith('::'));
  console.log(resources);
  console.log(resources.length);
});

// # terraform state show aws_instance.tf_test_ec2
