path = require 'path'

global.sails = require 'config'

React = require 'react'
E = require 'react-script'
ReactDOM = require 'react-dom'
MuiThemeProvider = require('material-ui/styles/MuiThemeProvider').default
AppBar = require('./appbar.coffee').component
CertList = require('./body.coffee').component

elem =
  E MuiThemeProvider,
    E 'div',
      E AppBar
      E CertList

ReactDOM.render elem, document.getElementById 'root'
