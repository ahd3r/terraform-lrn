const { exec } = require('child_process');

exec('terraform state list', (error, stdout, stderr) => {
  const resources = stdout
    .trim()
    .split('\n')
    .map((resource) => resource.trim())
    .filter(Boolean)
    .filter((resource) => !resource.startsWith('::'))
    .slice(1);

  resources.forEach(resource => {
    exec(`terraform state show ${resource}`, (error, stdout, stderr) => {
      console.log(stdout);
    });
  })
});
