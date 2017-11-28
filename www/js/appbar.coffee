React = require 'react'
E = require 'react-script'
AppBar = require('material-ui/AppBar').default
Drawer = require('material-ui/Drawer').default
MenuItem = require('material-ui/MenuItem').default
Auth = require 'rc-oauth2'

class _AppBar extends React.Component
  state:
    user: null
    open: false
  menu: =>
    @setState (state) ->
      state.open = not state.open
      true
  render: ->
    E AppBar, 
      title: document.title
      onLeftIconButtonTouchTap: @menu,
      E Drawer,
        open: @state.open
        docked: false
        E MenuItem,
          onClick: @menu,
          'List'
        E MenuItem,
          onClick: @menu,
          'Create'
      
module.exports =
  component: _AppBar 
