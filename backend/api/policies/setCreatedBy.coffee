module.exports = (req, res, next) ->
  req.body.createdBy = req.user.email
  next()
