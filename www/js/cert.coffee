co = require 'co'
React = require 'react'
update = require 'react-addons-update'
E = require 'react-script'
{List, ListItem} = require 'material-ui/List'
Avatar = require('material-ui/Avatar').default
Person = require('material-ui/svg-icons/social/person').default

class CertList extends React.Component
  render: ->
    E List, 
      @props.certs.map (cert) ->
        E ListItem,
          key: cert.id
          leftAvatar: E Avatar, icon: E Person
          primaryText: "#{cert.serial} - #{cert.createdBy.email}"
          secondaryText: "[#{cert.validity.start}, #{cert.validity.end}]"

reducer = (state, action) ->
  switch action.type
    when 'Cert.fetchAll.ok'
      update state, $push: action.certs
    else
      state || []
      
actionCreator = (dispatch) ->
  getCerts: ->
    dispatch
      type: 'Cert.fetchAll'

module.exports =
  component: CertList
  reducer: reducer
  actionCreator: actionCreator
