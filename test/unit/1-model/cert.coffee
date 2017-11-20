describe 'model', ->
  user = 'test@abc.com'
  key = null
  csr = null
  crt = null

  it 'create user', ->
    sails.models.user
      .findOrCreate 
        email: user

  it 'create private key', ->
    sails.models.cert.createPrivateKey()
      .then (newkey) ->
        key = newkey
        console.log key

  it 'create csr', ->
    sails.models.cert
      .createCSR 
        clientkey: key
        commonName: user
      .then (newcsr) ->
        csr = newcsr
        console.log csr

  it 'create certificate', ->
    sails.models.cert.createCert csr: csr
      .then (newcrt) ->
        crt = newcrt
        console.log crt

  it 'get public key', ->
    sails.models.user.findOne email: user
      .populateAll()
      .then (user) ->
         user?.certs[0].publicKey()
      .then console.log

  it 'get cert info', ->
    sails.models.user.findOne email: user
      .populateAll()
      .then (user) ->
         user?.certs[0].info()
      .then console.log

  it 'destroy user', ->
    sails.models.user.destroy email: user
