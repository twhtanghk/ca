isAuth = require './isAuth'

module.exports = (req, res, next) ->
  if req.param('id') == 'me'
    isAuth req, res, ->
      sails.models.user
        .findOne email: req.user.email
        .populateAll()
        .then res.ok, next
  else
    next()
