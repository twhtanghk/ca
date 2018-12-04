<template>
  <v-toolbar-items>
    <v-btn flat @click='login' v-if='email == null'>
      Login
    </v-btn>
    <v-menu offset-y v-if='email != null'>
      <v-btn flat slot='activator'>{{ email }}</v-btn>
      <v-list>
        <v-list-tile @click.stop='logout'>
          <v-list-tile-title>Logout</v-list-tile-title>
        </v-list-tile>
      </v-list>
    </v-menu>
  </v-toolbar-items>
</template>

<script lang='coffee'>
{User} = require('./model').default

export default
  data: ->
    email: null
  methods:
    login: ->
      @email = (await User.me()).email
    logout: ->
      @email = null
</script>
