    Promise = require 'bluebird'
    actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'
    toDataURL = Promise.promisify require('qrcode').toDataURL

    module.exports =
      secret: (req, res) ->
        pk = actionUtil.requirePk req
        Model = actionutil.parseModel req
        try
          user = await Model.findOne id: pk
          if user?.secret
            res.ok await toDataURL()
          else
            res.notFound()
        catch e
          res.serverError e
