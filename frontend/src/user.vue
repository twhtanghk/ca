<template>
  <v-toolbar-items>
    <v-btn flat @click='login' v-if='email == null'>
      Login
    </v-btn>

    <v-menu offset-y v-if='email != null'>
      <v-btn flat slot='activator'>
        {{ email }}
        <v-icon>arrow_drop_down</v-icon>
      </v-btn>
      <v-list>
        <v-list-tile @click.stop='create' v-if='cert == null'>
          <v-list-tile-title>Create Personal Cert</v-list-tile-title>
        </v-list-tile>

        <v-list-tile v-if='cert != null && ! enable'>
          <v-list-tile-title>
            Enable 2 Factor Auth
          </v-list-tile-title>
          <v-list-tile-action>
            <v-switch v-model='enable' @change='otp'/>
          </v-list-tile-action>
        </v-list-tile>

        <v-list-tile @click.stop='logout'>
          <v-list-tile-title>Logout</v-list-tile-title>
        </v-list-tile>
      </v-list>
    </v-menu>
  </v-toolbar-items>
</template>

<script lang='coffee'>
{eventBus} = require('./lib').default
{User} = require('./model').default

export default
  data: ->
    email: null
    enable: false
    cert: null
  methods:
    login: ->
      me = await User.me()
      @email = me.email
      @enable = me.enable
      @cert = if me.certs.length then me.certs[0] else null
    logout: ->
      @email = null
    create: ->
      eventBus.$emit 'cert.create'
    otp: ->
      eventBus.$emit 'user.otp', @enable
</script>
