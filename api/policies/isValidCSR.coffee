actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res, next) ->
  {csr} = actionUtil.parseValues req
  sails.models.cert
    .info csr
    .then (info) ->
      if info.commonName == req.user.email
        return next()
      res.negotiate new Error 'mismatch csr email and authenticated user'
    .catch sails.log.error
