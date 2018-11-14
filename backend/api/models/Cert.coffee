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

  customToJSON: ->
    _.omit @, 'key'

  publicKey: (cert) ->
    {publicKey} = await getPublicKeyAsync cert.crt
    publicKey

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
      serviceKey: ca.privateKeyPem()
      serviceKeyPassword: ca.passphrase
      serviceCertificate: ca.crt()
    createCertificateAsync opts
      .then ({certificate}) ->
        certificate

  beforeCreate: (values, cb) ->
    crt = ->
      id = values.createdBy?.id || values.createdBy
      user = await sails.models.user.findValidCertById id
      if user.certs.length != 0
        return cb new Error "valid certificate exists"
      values.key = await sails.models.cert.createPrivateKey()
      data =
          clientkey: values.key
          commonName: user.email
      csr = await sails.models.cert.createCSR data
      values.crt = await sails.models.cert.createCert csr: csr
      info = await readCertificateInfoAsync values.crt
      values.dtStart = new Date info.validity.start
      values.dtEnd = new Date info.validity.end
    crt()
      .then ->
        cb()
      .catch cb
