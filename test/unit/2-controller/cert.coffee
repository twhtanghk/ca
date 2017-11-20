co = require 'co'
Promise = require 'bluebird'

describe 'controller', ->
  Cert = null
  cert = null

  before -> co ->
    yield sails.config.oauth2.validToken sails.config.oauth2
    Cert = sails.config.cert.model()

  it 'sign user for invalid email', ->
    co Cert.createCert 'test@abc.com'
      .then Promise.reject, Promise.resolve
    
  it 'sign user', -> co ->
    cert = yield Cert.createCert sails.config.oauth2.user.email

  it 'revoke cert', -> co ->
    cert.revoke()
