_ = require 'lodash'
{decode64} = require('node-forge').util

module.exports =
  findByHash: (req, res) ->
    try
      hash = req.param 'hash'
      now = new Date
      action = await sails.models.action
        .findOne hash: req.param 'hash'
        .populate 'createdBy'
      data = JSON.parse sails.config.ca.privateKey().decrypt decode64 hash
      req.options.action = "#{data.model}/#{data.action}"
      _.extend req.body, _.omit(data, 'createdBy')
      sails.getActions()[req.options.action] req, res
    catch e
      res.serverError e
