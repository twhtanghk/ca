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
    transporter.sendMail
      from: sails.config.email.from
      to: values.createdBy
      subject: "#{values.action} for CA"
      html: sails.config.email.msg _.extend {}, values, cbUrl: ->
        "#{process.env.ROOTURL}/api/action?hash=#{values.hash}"
