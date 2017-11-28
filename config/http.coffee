module.exports =
  http:
    middleware:
      order: [
        'bodyParser'
        'router'
        'www'
        'favicon'
        '404'
        '500'
      ]
