module.exports =
  admin: [
    'admin@abc.com'
  ]
  ca:
    passphrase: 'password'
  oauth2:
    url:
      verify: 'https://mobtest.ml/auth/oauth2/verify/'
      token: 'https://mobtest.ml/auth/oauth2/token/'
    client:
      id: 'client_id'
      secret: 'client_secret'
    user:
      id: 'user_id'
      secret: 'user_secret'
      email: 'test@abc.com'
  log:
    level: 'silly'
