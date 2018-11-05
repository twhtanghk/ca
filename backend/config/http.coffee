module.exports =
  http:
    middleware:
      order: [
        'compress'
        'bodyParser'
        'methodOverride'
        'router'
        'www'
        'favicon'
      ]
