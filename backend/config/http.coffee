module.exports =
  http:
    middleware:
      methodOverride: require('method-override')()
      order: [
        'compress'
        'bodyParser'
        'methodOverride'
        'router'
        'www'
        'favicon'
      ]
