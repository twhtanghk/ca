    fs = require 'fs'
    crypto = require 'crypto'
    Promise = require 'bluebird'
    pem = Promise.promisifyAll require 'pem'
    {pki} = require 'node-forge'

    module.exports =
      ca:

default path of ca key file

        keyFile: './config/env/ssl/cakey.pem'

return private key in pem format

        privateKeyPem: ->
          fs.readFileSync(sails.config.ca.keyFile).toString()

return private key

        privateKey: ->
          pki
            .decryptRsaPrivateKey module.exports.ca.privateKeyPem(), module.exports.ca.passphrase

passphrase for private key

        passphrase: 'password'

default path of ca certificate file

        crtFile: './config/env/ssl/cacert.pem'

return certificate in pem format

        crt: ->
          fs.readFileSync(sails.config.ca.crtFile).toString()

return public key

        publicKey: ->
          pki
            .certificateFromPem module.exports.ca.crt()
            .publicKey

sign input csr and return promise of {certificate, csr, clientKey, serviceKey}

        createCertificate: (opts) ->
          _.defaults opts,
            serviceKey: module.exports.ca.privateKey()
            serviceKeyPassword: sails.config.ca.passphrase
          pem.createCertificateAsync opts
