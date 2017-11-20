Promise = require 'bluebird'
pem = Promise.promisifyAll require 'pem'

module.exports =
  tableName: 'user'
  schema: true
  autoPK: false
  attributes:
    email:
      type: 'email'
      unique: true
      required: true
      primaryKey: true
    certs:
      collection: 'cert'
      via: 'createdBy'
  afterDestroy: (records, cb) ->
    sails.models.cert
      .destroy createdBy: _.map(records, 'email')
      .exec cb
