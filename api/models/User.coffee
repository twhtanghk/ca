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
    org:
      type: 'string'
      defaultsTo: ->
        sails.config.user.org
    c:
      type: 'string'
      defaultsTo: ->
        sails.config.user.c
    publicKey:
      type: 'string'
