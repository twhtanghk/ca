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
      controller: 'ActionController'
      action: 'create'
      locals:
        model: 'user'
        action: 'otp'

    'GET /api/user/:id/qrcode':
      model: 'user'
      controller: 'UserController'
      action: 'secret'

    'POST /api/cert':
      controller: 'ActionController'
      action: 'create'
      locals:
        model: 'cert'
        action: 'create'

    'DELETE /api/cert/:id':
      model: 'cert'
      controller: 'CertController'
      action: 'destroy'

    'GET /api/action':
      controller: 'ActionController'
      action: 'findByHash'
