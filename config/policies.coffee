module.exports =
  policies:
    UserController:
      '*': false
      findOne: true
      find: true
    CertController:
      '*': false
      sign: ['isAuth', 'isValidCSR' ]
      revoke: ['isAuth']
