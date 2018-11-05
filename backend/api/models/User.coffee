Promise = require 'bluebird'
pem = Promise.promisifyAll require 'pem'

module.exports =
  tableName: 'user'
  schema: true
  primaryKey: 'email'
  attributes:
    email:
      type: 'string'
      unique: true
      required: true
    certs:
      collection: 'cert'
      via: 'createdBy'
  afterDestroy: (records, cb) ->
    sails.models.cert
      .destroy createdBy: _.map(records, 'email')
      .exec cb
