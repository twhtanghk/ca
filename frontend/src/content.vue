<template>
  <v-list two-line>
    <v-list-tile v-for='user in users' :key=user.id avatar @click='select'>
      <v-list-tile-avatar>
        <v-icon>verified_user</v-icon>
      </v-list-tile-avatar>
      <v-list-tile-content>
        <v-list-tile-title>{{ user.email }}</v-list-tile-title>
        <v-list-tile-sub-title v-if='user.certs.length > 0'>{{ user.certs[0].dtStart }} - {{ user.certs[0].dtEnd }}</v-list-tile-sub-title>
      </v-list-tile-content>
      <v-list-tile-action>
        <v-btn icon ripple>
          <v-icon color='grey lighten-1'>info</v-icon>
        </v-btn>
      </v-list-tile-action>
    </v-list-tile>
  </v-list>
</template>

<script lang='coffee'>
{eventBus} = require('./lib').default
{User, Cert} = require('./model').default

export default
  extends: require('vue.model/src/model').default
  data: ->
    users: []
  methods:
    list: ->
      @users = []
      for await page from User.iterPage sort: email: 1
        @users = @users.concat page
    create: ->
      cert = await Cert.create()
      @list()
  created: ->
    @list()
    eventBus
      .$on 'user.list', @list
      .$on 'cert.create', @create
</script>
