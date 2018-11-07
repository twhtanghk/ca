module.exports =
  policies:
    UserController:
      '*': false
      findOne: true
      find: true
      otp: ['isAuth']
      verify: ['isAuth']
    CertController:
      '*': false
      create: ['isAuth', 'setCreatedBy']
      findByEmail: true
      findOne: true
      find: true
      destroy: ['isAuth', 'isOwner']
