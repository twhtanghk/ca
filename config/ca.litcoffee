    fs = require 'fs'
    crypto = require 'crypto'
    Promise = require 'bluebird'
    pem = Promise.promisifyAll require 'pem'

    module.exports =
      ca:

default path of ca key file

        keyFile: './data/private/cakey.pem'

return private key in pem format

        privateKey: ->
          fs.readFileSync(sails.config.ca.keyFile).toString()

passphrase for private key

        passphrase: 'password'

default path of ca certificate file

        crtFile: './data/cacert.pem'

return certificate in pem format

        crt: ->
          fs.readFileSync(sails.config.ca.crtFile).toString()

sign input csr and return promise of {certificate, csr, clientKey, serviceKey}

        createCertificate: (opts) ->
          _.defaults opts,
            serviceKey: module.exports.ca.privateKey()
            serviceKeyPassword: sails.config.ca.passphrase
          pem.createCertificateAsync opts
