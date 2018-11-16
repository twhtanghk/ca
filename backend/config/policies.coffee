module.exports =
  policies:
    UserController:
      '*': false
      findOne: true
      find: true
      otp: ['isAuth']
    CertController:
      '*': false
      create: ['isAuth', 'setCreatedBy']
      findByEmail: true
      findOne: true
      find: true
      destroy: ['isAuth', 'isOwner']
    ActionController:
      '*': false
      create: ['isAuth', 'setCreatedBy', 'parseAction']
      findByHash: ['isAuth', 'setCreatedBy']
