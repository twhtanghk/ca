module.exports =
  routes:
    'GET /api/user/:id':
      controller: 'UserController'
      action: 'findOne'
    'GET /api/user':
      controller: 'UserController'
      action: 'find'
    'POST /api/cert':
      controller: 'CertController'
      action: 'sign'
    'PUT /api/cert/:id':
      controller: 'CertController'
      action: 'revoke'
