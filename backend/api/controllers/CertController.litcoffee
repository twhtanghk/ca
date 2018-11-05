    actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

    module.exports =
      findByEmail: (req, res) ->
        values = actionUtil.parseValues req
        if not('email' of values)
          return res.serverError 'email attribute not defined'
        sails.models.cert
          .findValidOne values.email, values.asAt
          .then (crt) ->
            if crt?
              res.ok _.omit crt, 'key'
            else
              res.notFound()
          .catch res.serverError
      destroy: (req, res) ->
        req.body.revokedAt = new Date()
        if not('revokedReason' of actionUtil.parseValues req)
          return res.serverError 'revokedReason attribute not defined'
        sails.getActions()['cert/update'] req, res
