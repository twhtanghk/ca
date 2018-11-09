module.exports =
  admin: [
    'admin@abc.com'
  ]
  ca:
    passphrase: 'password'
  oauth2:
    url:
      verify: 'https://abc.com/auth/oauth2/verify/'
      token: 'https://abc.com/auth/oauth2/token/'
    client:
      id: process.env.CLIENT_ID
      secret: process.env.CLIENT_SECRET
    user:
      id: process.env.USER_ID
      secret: process.env.USER_SECRET
      email: process.env.USER_EMAIL
  email:
    from: process.env.SMTP_FROM
    opts:
      host: process.env.SMTP_HOST
  log:
    level: 'silly'
