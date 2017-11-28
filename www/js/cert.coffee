co = require 'co'
React = require 'react'
E = require 'react-script'
{List, ListItem} = require 'material-ui/List'
Avatar = require('material-ui/Avatar').default
Person = require('material-ui/svg-icons/social/person').default
Cert = sails.config.cert.model()

class CertList extends React.Component
  state:
    certs: []
  componentDidMount: ->
    co Cert.fetchAll()
      .then (iter) =>
        ret = []
        for i from iter()
          ret.push i
        @setState certs: ret
  render: ->
    E List, 
      @state.certs.map (cert) ->
        E ListItem,
          key: cert.id
          leftAvatar: E Avatar, icon: E Person
          primaryText: "#{cert.serial} - #{cert.createdBy.email}"
          secondaryText: "[#{cert.validity.start}, #{cert.validity.end}]"
      
module.exports =
  component: CertList
