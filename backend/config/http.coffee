{series} = require 'middleware-flow'

urlPolicy = (req, res, next) ->
  data = 
    'POST /api/cert': [
      'isAuth'
      'noCert'
    ]
    'PUT /api/user/otp': [
      'isAuth'
      sails.services.user.isEnabled not req.param 'enable'
    ]

  for path, policies of data
    r = new RegExp path
    if r.test "#{req.method} #{req.path}"
      policies = _.map policies, (policy) ->
        if typeof policy == 'string'
          require "../api/policies/#{policy}"
        else
          policy
      mw = series.apply null, policies   
      return mw req, res, next

  next()

module.exports =
  http:
    middleware:
      methodOverride: require('method-override')()
      urlPolicy: urlPolicy
      order: [
        'compress'
        'bodyParser'
        'methodOverride'
        'urlPolicy'
        'router'
        'www'
        'favicon'
      ]
