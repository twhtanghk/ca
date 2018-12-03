{decode64} = require('node-forge').util

module.exports =
  findByHash: (req, res) ->
    try
      user = await sails.models.user.findOne email: req.user.email
      hash = req.param 'hash'
      now = new Date
      action = await sails.models.action
        .find
          hash: hash
          createdBy: user.id
          createdAt:
            '>=': new Date(Date.now() - process.env.VALIDITY * 60000)
            '<': new Date()
      if action?
        data = JSON.parse sails.config.ca.privateKey().decrypt decode64 hash
        req.options.action = "#{data.model}/#{data.action}"
        _.extend req.body, _.omit(data, 'createdBy')
        sails.getActions()[req.options.action] req, res
      else
        res.badRequest 'Action expired or unauthorized access'
    catch e
      res.serverError e
