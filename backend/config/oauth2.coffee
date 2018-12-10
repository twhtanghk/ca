_ = require 'lodash'

opts =
  url:
    verify: process.env.VERIFY_URL
    token: process.env.TOKEN_URL
  client:
    id: process.env.CLIENT_ID
    secret: process.env.CLIENT_SECRET
  user:
    id: process.env.USER_ID
    secret: process.env.USER_SECRET
    email: process.env.USER_EMAIL

module.exports = 
  oauth2: _.defaultsDeep opts, require('activerecord-model').oauth2
