module.exports = (req, res, next) ->
  sails.models.user
    .findValidCertByEmail req.user.email
    .then (user) ->
      if user.certs.length
        return next new Error "valid certificate already available"
      next()
    .catch next
