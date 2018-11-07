module.exports =
  admin: process.env.ADMIN.split ','
  ca:
    passphrase: process.env.CAKEY_SECRET
  oauth2:
    url:
      verify: 'https://mobtest.ml/auth/oauth2/verify/'
