co = require 'co'
Promise = require 'bluebird'
req = require 'supertest'

describe 'controller', ->
  cert = null
  token = null

  before -> co ->
    token = yield sails.config.oauth2.validToken sails.config.oauth2

  it 'create cert', ->
    req sails.hooks.http.app
      .post '/api/cert'
      .set 'Authorization', "Bearer #{token}"
      .set 'Content-Type', 'application/json'
      .send()
      .expect 200
      .then (res) ->
        sails.log.info res.body

  it 'findByEmail cert', ->
    req sails.hooks.http.app
      .get "/api/cert/email?email=#{sails.config.oauth2.user.email}"
      .set 'Content-Type', 'application/json'
      .send()
      .expect 200
      .then (res) ->
        cert = res.body
        sails.log.info res.body

  it 'find cert', ->
    req sails.hooks.http.app
      .get '/api/cert'
      .set 'Content-Type', 'application/json'
      .send()
      .expect 200
      .then (res) ->
        sails.log.info res.body

  it 'destroy cert', ->
    req sails.hooks.http.app
      .del "/api/cert/#{cert.id}"
      .set 'Authorization', "Bearer #{token}"
      .set 'Content-Type', 'application/json'
      .send revokedReason: 'revoke test'
      .expect 200
      .then (res) ->
        sails.log.info res.body  
