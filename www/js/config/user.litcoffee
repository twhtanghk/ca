    forge = require 'node-forge'

    module.exports =
      user:
        url: 'https://abc.com/api/user'
        model: (url = sails.config.user.url) ->
          stamp = sails.config
            .armodel url
            .methods
              getStamp: ->
                stamp
            .statics
              idAttribute: 'email'
              _me: null
              me: ->
                if _me?
                  _me
                else
                  _me = stamp email: 'me'
                  yield _me.fetch()
