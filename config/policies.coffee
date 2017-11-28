module.exports =
  policies:
    UserController:
      '*': false
      findOne: true
      find: true
    CertController:
      '*': false
      find: true
      findMy: ['isAuth', 'setCreatedBy']
      sign: ['isAuth', 'isValidCSR' ]
      revoke: ['isAuth']
