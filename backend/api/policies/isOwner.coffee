actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res, next) ->
  pk = parseInt actionUtil.requirePk req
  sails.log.debug typeof pk
  sails.log.debug "#{pk} #{req.user.email}"
  sails.log.debug req.options
  Model = actionUtil.parseModel req
  Model.findOne id: pk, createdBy: req.user.email
    .then (model) ->
      if model?
        next()
      else
        res.forbidden()
