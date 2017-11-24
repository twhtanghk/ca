React = require 'react'
E = require 'react-script'
{List, ListItem} = require 'material-ui/List'
Cert = sails.config.cert.model()

class CertList extends React.Component
  state:
    certs: []
  componentDidMount: ->
    @setState certs: Cert.fetch()
  render: ->
    E List, 
      @state.certs.map (cert) ->
        E ListItem,
          primaryText: cert.toJSON()
      
module.exports =
  component: CertList
