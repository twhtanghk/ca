_ = require 'lodash'
_.defaults = require 'merge-defaults'

global.sails = 
  config: [
    require './config/api.coffee'
    require './config/armodel.coffee'
    require './config/cert.litcoffee'
    require './config/oauth2.coffee'
    require './config/promise.coffee'
    require './config/user.litcoffee'
    require './config/env/production.coffee'
  ].reduce _.defaults, {}
