module.exports =
  policies:
    UserController:
      '*': false
      findOne: true
      find: true
    CertController:
      '*': false
      create: ['isAuth', 'setCreatedBy']
      findByEmail: true
      findOne: true
      find: true
      destroy: ['isAuth', 'isOwner']
