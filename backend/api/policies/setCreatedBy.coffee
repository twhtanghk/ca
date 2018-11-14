module.exports = (req, res, next) ->
  sails.models.user
    .findOne email: req.user.email
    .then (user) ->
      req.body.createdBy = user.id
      next()
    .catch next
