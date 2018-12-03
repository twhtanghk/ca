isAuth = require './isAuth'

module.exports = (req, res, next) ->
  if req.param('id') == 'me'
    isAuth req, res, ->
      sails.models.user
        .findOne email: req.user.email
        .then (user) ->
          req.params.id = user.id
          next()
        .catch res.serverError
  else
    next()
