module.exports =
  tableName: 'user'
  schema: true
  attributes:
    id:
      type: 'number'
      autoIncrement: true
    email:
      type: 'string'
      unique: true
      required: true
    secret:
      type: 'string'
    certs:
      collection: 'cert'
      via: 'createdBy'
  beforeDestroy: (records, cb) ->
    crt = ->
      await sails.models.cert
        .destroy createdBy: _.map(records, 'id')
    crt()
      .then ->
        cb()
      .catch cb
  findValidCertById: (id) ->
    sails.models.user
      .findOne id: id
      .populate('certs', {revokedReason: '', revokedAt: null})
  findValidCertByEmail: (email) ->
    sails.models.user
      .findOne email: email
      .populate('certs', {revokedReason: '', revokedAt: null})
  otp: (user, enable) ->
    sails.models.email
      .create
        hash: sails.config.ca.publicKey().encrypt JSON.stringify
          otp: enable
          createdAt: new Date()
        createdBy: user.id
      .meta fetch: true
  # assume verified action not yet expired
  verify: (user, hash) ->
    data = JSON.parse sails.config.ca.privateKey().decrypt hash
    data.createdAt = new Date()
    secret = null
    if data.otp
      secret = sails.config.ca.publicKey().encrypt JSON.stringify data
    sails.models.user.update {id: user.id}, {secret: secret}
