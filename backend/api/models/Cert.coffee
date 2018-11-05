_ = require 'lodash'
Promise = require 'bluebird'
{createPrivateKeyAsync, createCSRAsync, createCertificateAsync, readCertificateInfoAsync, getPublicKeyAsync, readCertificateInfoAsync} = Promise.promisifyAll require 'pem'

module.exports =
  tableName: 'cert'
  schema: true
  attributes:
    id:
      type: 'number'
      autoIncrement: true
    key:
      type: 'string'
    crt:
      type: 'string'
    dtStart:
      type: 'ref'
      columnType: 'datetime'
    dtEnd:
      type: 'ref'
      columnType: 'datetime'
    createdBy:
      model: 'user'
      required: true
    revokedAt:
      type: 'ref'
      columnType: 'datetime'
    revokedReason:
      type: 'string'

  publicKey: (cert) ->
    getPublicKeyAsync cert.crt
      .then (res) ->
        res.publicKey

  info: (cert) ->
    readCertificateInfoAsync cert.crt

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
    createCertificateAsync opts
      .then ({certificate}) ->
        certificate

  beforeCreate: (values, cb) ->
    sails.models.cert
      .findValidOne values.createdBy
      .then (crt) ->
        if crt == null
          return
        Promise.reject new Error "valid certificate exists"
      .then ->
        sails.models.cert.createPrivateKey()
      .then (key) ->
        values.key = key
      .then ->
        sails.models.cert.createCSR
          clientkey: values.key
          commonName: values.createdBy
      .then (csr) ->
        sails.models.cert.createCert csr: values.csr
      .then (crt) ->
        values.crt = crt
        readCertificateInfoAsync crt
      .then (info) ->
        sails.log.info info
        values.dtStart = new Date info.validity.start
        values.dtEnd = new Date info.validity.end
      .then ->
        cb()
      .catch cb
        
  findValidOne: (email, asAt = new Date()) ->
    sails.models.cert
      .find()
      .where
        createdBy: email
        revokedAt: null
        revokedReason: ''
        dtStart:
          '<=': asAt
        dtEnd:
          '>=': asAt
      .then (certs) ->
        certs[0] || null
