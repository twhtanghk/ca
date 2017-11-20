_ = require 'lodash'
Promise = require 'bluebird'
{createPrivateKeyAsync, createCSRAsync, createCertificateAsync, readCertificateInfoAsync, getPublicKeyAsync, readCertificateInfoAsync} = Promise.promisifyAll require 'pem'

module.exports =
  tableName: 'cert'
  schema: true
  attributes:
    pem:
      type: 'string'
      required: true
    serial:
      type: 'string'
      required: true
    validity:
      type: 'json'
      required: true
    createdBy:
      model: 'user'
      required: true
    revokedAt:
      type: 'date'
    revokedReason:
      type: 'string'
    publicKey: ->
      getPublicKeyAsync @pem
        .then (res) ->
          res.publicKey
    info: ->
      sails.models.cert.info @pem
  info: (pem) ->
    readCertificateInfoAsync pem
  createPrivateKey: (opts) ->
    createPrivateKeyAsync()
      .then (res) ->
        res.key
  createCSR: (opts) ->
    createCSRAsync opts
      .then (res) ->
        res.csr
  createCert: (opts) ->
    ca = sails.config.ca
    opts = _.defaults {}, opts,
      selfSigned: false
      serviceKey: ca.privateKey()
      serviceKeyPassword: ca.passphrase
      serviceCertificate: ca.crt()
    Promise
      .all [
        createCertificateAsync opts
        readCertificateInfoAsync opts.csr
      ]
      .then (res) =>
        {certificate} = res[0]
        {commonName} = res[1]
        @create
          pem: certificate
          createdBy: commonName 
  beforeValidate: (values, cb) ->
    if values.pem?
      @info values.pem
        .then (res) ->
          _.each res.validity, (value, key) ->
            res.validity[key] = new Date value
          _.extend values, _.pick(res, 'validity', 'serial')
          cb()
        .catch cb
    else
      cb()
  beforeCreate: (values, cb) ->
    @findValidOne values.createdBy
      .then (crt) ->
        if crt == null
          return cb()
        cb new Error "valid certificate exists"
  findValid: (email) ->
    now = new Date()
    @find()
      .where
        createdBy: email
        revokedAt: null
        reavokedReason: null
      .then (certs) ->
        now = new Date()
        certs = _.filter certs, (cert) ->
          start = new Date cert.validity.start
          end = new Date cert.validity.end
          start <= now and now <= end
        _.sortBy(certs, 'validity.end').reverse()
  findValidOne: (email) ->
    @findValid email
      .then (certs) ->
        certs[0] || null
