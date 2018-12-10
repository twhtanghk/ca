    Promise = require 'bluebird'
    {authenticator} = require 'otplib'
    toDataURL = Promise.promisify require('qrcode').toDataURL

    module.exports =
      otp: (req, res) ->
        enable = req.param 'enable', null
        if enable?
          user = await sails.models.user.findOne email: req.user.email
          secret = ''
          if enable
            secret = authenticator.generateSecret()
          user = await sails.models.user.updateOne {id: user.id}, {secret: secret}
          if enable
            img = await toDataURL authenticator.keyuri user.email, 'ca', user.secret
            res.ok img
          else
            res.ok()
        else
          res.serverError 'parameter enable not defined'
