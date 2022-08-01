const express = require('express');
const {default: helmet} = require('helmet');
const cors = require('cors');

const app = express();

app.use(cors({origin: '*'}));
app.use(helmet());
app.use(express.json());

app.get('/', (req,res) => {
  res.status(200).send({message: 'Runnign!'});
});

app.get('/error', (req,res) => {
  res.status(400).send({message: 'Error'});
});

app.listen(3000, ()=>{
  console.log('Running app in port 3000...');
});
