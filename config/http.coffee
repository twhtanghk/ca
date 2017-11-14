module.exports =
  http:
    middleware:
      order: [
        'compress'
        'bodyParser'
        'router'
        'www'
        'favicon'
        '404'
        '500'
      ]
