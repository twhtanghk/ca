co = require 'co'

Cert = sails.config.cert.model()

module.exports = [
  (store) -> (dispatch) -> (action) ->
    switch action.type
      when 'Cert.fetchAll'
        co Cert.fetchAll()
          .then (iter) ->
            ret = []
            for i from iter()
              ret.push i
            dispatch
              type: 'Cert.fetchAll.ok'
              certs: ret
          .catch (err) ->
            console.log err
]
