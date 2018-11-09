    Promise = require 'bluebird'
    actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'
    toDataURL = Promise.promisify require('qrcode').toDataURL
    {encode64, decode64} = require('node-forge').util

    module.exports =
      otp: (req, res) ->
        flag = req.param 'flag', null
        if flag?
          data =
            createdAt: new Date()
            otp: flag
          sails.models.email
            .create
              hash: encode64 sails.config.ca.publicKey().encrypt JSON.stringify data
              createdBy: req.user
            .then ->
              res.ok()
        else
          res.serverError 'parameter flag not defined'
      verify: (req, res) ->
        hash = req.param 'hash', null
        sails.log.info hash
        if hash == null
          res.serverError 'parameter hash not defined'
        action = await sails.models.email
          .findOne
            hash: hash
            createdAt:
              '>=': new Date(Date.now() - process.env.VALIDITY * 60000)
              '<': new Date()
        if action?
          await sails.models.user.verify req.user, hash
          res.ok()
        else
          res.serverError "No such email verificiation or expired with #{process.env.VALIDIY} min"
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
