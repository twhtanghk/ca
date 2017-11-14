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
    c:
      type: 'string'
      defaultsTo: ->
        sails.config.user.c
    publicKey:
      type: 'string'
