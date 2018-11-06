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
  afterDestroy: (records, cb) ->
    sails.models.cert
      .destroy createdBy: _.map(records, 'email')
      .exec cb
