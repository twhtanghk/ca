module.exports =
  routes:
    'GET /api/user':
      controller: 'UserController'
      action: 'find'

    'GET /api/user/:id':
      model: 'user'
      controller: 'UserController'
      action: 'findOne'

    'PUT /api/user/otp':
      model: 'user'
      controller: 'UserController'
      action: 'otp'

    'GET /api/user/verify/:hash':
      model: 'user'
      controller: 'UserController'
      action: 'verify'

    'GET /api/user/:id/qrcode':
      model: 'user'
      controller: 'UserController'
      action: 'secret'

    'POST /api/cert':
      controller: 'CertController'
      action: 'create'

    'DELETE /api/cert/:id':
      model: 'cert'
      controller: 'CertController'
      action: 'destroy'
