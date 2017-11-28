require 'react-redux-toastr/lib/css/react-redux-toastr.min.css'

require './config.coffee'
React = require 'react'
E = require 'react-script'
ReactDOM = require 'react-dom'
MuiThemeProvider = require('material-ui/styles/MuiThemeProvider').default
AppBar = require('./appbar.coffee').component

{compose, createStore, combineReducers, applyMiddleware} = require 'redux'
{Provider, connect} = require 'react-redux'
Auth = require 'rc-oauth2'
CertList = require('./cert.coffee').component
Toastr = require 'react-redux-toastr'
co = require 'co'

initState =
  auth: Auth.state
  data: CertList.state

reducer = combineReducers
  auth: Auth.reducer
  toastr: Toastr.reducer

composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose

store = createStore reducer, initState, composeEnhancers()

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

AuthC = connect(((state) -> state.auth), Auth.actionCreator)(Auth.component)

elem =
  E Provider, store: store,
    E MuiThemeProvider,
      E 'div',
        E Toastr.default
        E AuthC,
          AUTHURL: sails.config.oauth2.url.authorize
          CLIENT_ID: sails.config.oauth2.client.id
          SCOPE: sails.config.oauth2.scope
        E AppBar
        E CertList
  
ReactDOM.render elem, document.getElementById 'root'
