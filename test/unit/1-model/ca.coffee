crypto = require 'crypto'

describe 'model', ->
  it 'create user', ->
    ecdh = crypto.createECDH 'secp521r1'
    key =
      public: ecdh.generateKeys 'base64'
      private: ecdh.getPrivateKey 'base64'
    sails.log.debug key
    sails.models.user
      .create email: 'test@abc.com'
