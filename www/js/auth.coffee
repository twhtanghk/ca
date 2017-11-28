sails.config.oauth2.getToken = (opt) ->
  yield new Promise (resolve, reject) ->
    store.dispatch type: 'login'
    unsubscribe = store.subscribe ->
      if sails.config.oauth2.token != store.getState().auth.token
        sails.config.oauth2.token = store.getState().auth.token
        unsubscribe()
        resolve sails.config.oauth2.token
      if sails.config.oauth2.error != store.getState().auth.error
        sails.config.oauth2.error = store.getState().auth.error
        unsubscribe()
        reject sails.config.oauth2.error
