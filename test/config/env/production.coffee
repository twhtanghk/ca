module.exports =
  user:
    url: 'http://localhost:1337/api/user'
  cert:
    url: 'http://localhost:1337/api/cert'
  oauth2:
    url:
      verify: 'https://abc.com/auth/oauth2/verify/'
    client:
      id: 'client_id'
      secret: 'client_secret'
    user:
      id: 'user_id'
      secret: 'user_secret'
      email: 'user_email'
