const authorizer = require('./authorizer');

exports.handler = async (event) => {

  try {
    return await authorizer.authenticate(event);
  }
  catch (err) {
      console.log(err);
      return `Unauthorized: ${err.message}`;
  }
};


