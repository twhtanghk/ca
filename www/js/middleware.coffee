co = require 'co'

Cert = sails.config.cert.model()
{toastr} = require 'react-redux-toastr'

module.exports =
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
            toastr.error err.message
      when 'Cert.fetchMyCert'
        co Cert.fetchMyCert()
          .then (iter) ->
            ret = []
            for i from iter()
              ret.push i
            dispatch
              type: 'Cert.fetchAll.ok'
              certs: ret
          .catch (err) ->
            toastr.error err.message
      else
        dispatch action
