{encode64} = require('node-forge').util

module.exports = (req, res, next) ->
  data = _.extend req.options.locals, req.allParams()
  req.body.hash = encode64 sails.config.ca.publicKey().encrypt JSON.stringify data
  next()
