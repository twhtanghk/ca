authenticator = require 'otplib/authenticator'

module.exports =
  tableName: 'email'
  schema: true
  attributes:
    id:
      type: 'number'
      autoIncrement: true
    hash:
      type: 'string'
    createdBy:
      model: 'user'
      required: true
  afterCreate: (values, cb) ->
    transporter = require('nodemailer').createTransport sails.config.email.opts
    mail = ->
      user = await sails.models.user.findOne id: values.createdBy
      cbUrl = "#{process.env.ROOTURL}/api/verify?hash=#{values.hash}"
      transporter.sendMail
        from: sails.config.email.from
        to: user.email
        subject: "User Verification for CA"
        html: sails.config.email.msg cbUrl: cbUrl
    mail()
      .then ->
        cb()
      .catch cb
