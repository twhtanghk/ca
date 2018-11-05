describe 'model', ->
  user = 'test@abc.com'
  key = null
  csr = null
  crt = null

  it 'create user', ->
    sails.models.user
      .findOrCreate {email: user}, {email: user}

  it 'create private key', ->
    sails.models.cert.createPrivateKey()
      .then (newkey) ->
        key = newkey

  it 'create csr', ->
    sails.models.cert
      .createCSR 
        clientkey: key
        commonName: user
      .then (newcsr) ->
        csr = newcsr

  it 'create certificate', ->
    sails.models.cert.create createdBy: user
      .then (newcrt) ->
        crt = newcrt

  it 'get public key', ->
    sails.models.user.findOne email: user
      .populateAll()
      .then (user) ->
         sails.models.cert.publicKey user?.certs[0]

  it 'get cert info', ->
    sails.models.user.findOne email: user
      .populateAll()
      .then (user) ->
         sails.models.cert.info user?.certs[0]

  it 'destroy cert', ->
    sails.models.cert.destroy createdBy: user
