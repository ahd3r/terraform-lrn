const { exec } = require('child_process');

exec('terraform state list', (error, stdout, stderr) => {
  const resources = stdout
    .trim()
    .split('\n')
    .map((resource) => resource.trim())
    .filter(Boolean)
    .filter((resource) => !resource.startsWith('::'))
    .slice(1);
  console.log(resources);
});

// # terraform state show aws_instance.tf_test_ec2
