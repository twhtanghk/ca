<template>
  <v-list two-line>
    <v-list-tile v-for='cert in certs' :key=cert.id avatar @click='select'>
      <v-list-tile-avatar>
        <v-icon>verified_user</v-icon>
      </v-list-tile-avatar>
      <v-list-tile-content>
        <v-list-tile-title>{{ item.email }}</v-list-tile-title>
        <v-list-tile-sub-title>{{ item.dtEnd }}</v-list-tile-sub-title>
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
eventBus = require('vue.oauth2/src/eventBus').default

export default
  extends: require('vue.model/src/model').default
  data: ->
    certs: []
  created: ->
    for await page from @iterPage sort: email: 1
      @certs.concat page
</script>
