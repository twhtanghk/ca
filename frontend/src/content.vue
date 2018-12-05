<template>
  <v-list two-line>
    <v-list-tile v-for='user in users' :key=user.id avatar @click='select'>
      <v-list-tile-avatar>
        <font-awesome-icon :icon='icon(user)' />
      </v-list-tile-avatar>
      <v-list-tile-content>
        <v-list-tile-title>{{ user.email }}</v-list-tile-title>
        <v-list-tile-sub-title v-if='user.certs.length'>
          {{ user.certs[0].dtStart }} - {{ user.certs[0].dtEnd }}
        </v-list-tile-sub-title>
      </v-list-tile-content>
    </v-list-tile>
  </v-list>
</template>

<script lang='coffee'>
_ = require 'lodash'
{eventBus} = require('./lib').default
{User, Cert} = require('./model').default

export default
  extends: require('vue.model/src/model').default
  data: ->
    users: []
  methods:
    icon: (user) ->
      if user.secret?
        'user-lock'
      else if user.certs.length
        'user-shield'
      else
        'user'
    list: (opts = {}) ->
      @users = []
      for await page from User.iterPage data: _.defaults(sort: [email: 'ASC'], opts)
        @users = @users.concat page
    create: ->
      cert = await Cert.create()
      @list()
    otp: (enable = true) ->
      User.update 
        url: "#{User.baseUrl}/otp"
        data:
          enable: enable
    search: (text) ->
      @list email: contains: text
  created: ->
    @list()
    eventBus
      .$on 'user.list', @list
      .$on 'cert.create', @create
      .$on 'user.otp', @otp
      .$on 'search', @search
</script>
