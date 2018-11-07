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
  customToJSON: ->
    _.omit _.extend(@, '2fa': @secret?), secret
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
