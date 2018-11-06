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
    ###
      allowed values:
        enable 2 factor
        disable 2 factor
    ###
    action:
      type: 'string'
      required: true
    createdBy:
      model: 'user'
      required: true
  beforeCreate: (values, cb) ->
    values.hash = authenticator.generateSecret()
    cb()
  afterCreate: (values, cb) ->
    transporter = require('nodemailer').createTransport sails.config.email.opts
    transporter.sendMail
      from: sails.config.email.from
      to: values.createdBy
      subject: "#{values.action} for CA"
      html: sails.config.email.msg _.extend {}, values, cbUrl: ->
        "#{process.env.ROOTURL}/api/action?hash=#{values.hash}"
