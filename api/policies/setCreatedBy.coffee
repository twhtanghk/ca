module.exports = (req, res, next) ->
  req.where ?= {}
  req.where.createdBy = req.user.email
  next()
