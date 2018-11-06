actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res, next) ->
  pk = parseInt actionUtil.requirePk req
  Model = actionUtil.parseModel req
  Model.findOne id: pk, createdBy: req.user.email
    .then (model) ->
      if model?
        next()
      else
        res.forbidden()
