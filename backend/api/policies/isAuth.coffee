{isAuth} = require 'sails_policy'

module.exports = (req, res, next) ->
  isAuth req, res, ->
    sails.log.info 'isAuth'
    sails.models.user
      .findOrCreate {email: req.user.email}, {email: req.user.email}
      .then ->
        next()
      .catch res.serverError
