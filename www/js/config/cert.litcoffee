    forge = require 'node-forge'

    module.exports =
      cert:
        url: 'https://abc.com/api/cert'
        model: (url = sails.config.cert.url) ->
          stamp = sails.config
            .armodel url
            .methods
              getStamp: ->
                stamp
              revoke: (reason = 'privilegeWithdrawn') ->
                yield @save revokedReason: reason
            .statics

send pem format of created CSR to server

              createCert: (email) ->
                keys = forge.pki.rsa.generateKeyPair 2048
                csr = forge.pki.createCertificationRequest()
                csr.publicKey = keys.publicKey
                csr.setSubject [
                  {name: 'countryName', value: 'HK'}
                  {name: 'commonName', value: email}
                ]
                csr.sign keys.privateKey
                cert = stamp csr: forge.pki.certificationRequestToPem csr
                yield cert.save()

fetch list of my certificates

              fetchMyCert: ->
                @fetchAll url: '/api/my/cert'

            .use sails.config.api()
