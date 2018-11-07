describe 'model', ->
  email = 'test@abc.com'
  user = null
  key = null
  csr = null
  crt = null

  it 'create user', ->
    user = await sails.models.user
      .findOrCreate {email: email}, {email: email}

  it 'create private key', ->
    key = await sails.models.cert
      .createPrivateKey()

  it 'create csr', ->
    csr = await sails.models.cert
      .createCSR 
        clientkey: key
        commonName: user.email

  it 'create certificate', ->
    crt = await sails.models.cert
      .create createdBy: user.id

  it 'get public key', ->
    user = await sails.models.user
      .findValidCertByEmail user.email
      .populateAll()
    sails.models.cert.publicKey user?.certs[0]

  it 'get cert info', ->
    user = await sails.models.user
      .findValidCertByEmail user.email
    sails.models.cert.info user?.certs[0]

  it 'destroy user', ->
    sails.models.user.destroy id: user.id
