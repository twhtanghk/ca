module.exports = (req, res, next) ->
  enable = req.param 'enable'
  sails.models.user
    .findOne email: req.user.email
    .then (user) ->
      req.body.where = id: user.id
      next()
    .catch res.serverError
