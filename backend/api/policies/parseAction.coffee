{encode64} = require('node-forge').util

module.exports = (req, res, next) ->
  req.body.hash = encode64 sails.config.ca.publicKey().encrypt JSON.stringify req.options.locals
  next()
