const Joi = require('joi');

const handler = async (event) => {
  const validatedEvent = Joi.object({
    sequence: Joi.number().min(3).max(30).required()
  }).validate(event);
  if(validatedEvent.error){
    return validatedEvent.error;
  }
  const fib = [0,1];
  while (fib.length !== validatedEvent.value.sequence) {
    fib.push(fib[fib.length-1] + fib[fib.length-2])
  }
  return fib[fib.length-1];
};

module.exports = { handler };
