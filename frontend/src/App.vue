<template>
  <v-app>
    <authForm :eventBus='eventBus' :oauth2='oauth2' />
    <drawer />
    <toolbar />
    <users />
  </v-app>
</template>

<script lang='coffee'>
Vue = require('vue').default
{eventBus} = require('./lib').default
{Action} = require('./model').default
Vuetify = require 'vuetify'

Vue.use Vuetify, iconfont: 'fa'

export default
  name: 'app'
  components:
    drawer: require('./drawer').default
    toolbar: require('./toolbar').default
    users: require('./content').default
  data: ->
    eventBus: eventBus
    oauth2:
      url: process.env.AUTH_URL
      client: process.env.CLIENT_ID
      scope: 'User'
      response_type: 'token'
  mounted: ->
    url = new URL window.location
    hash = url.searchParams.get('hash')
    if hash?
      Action
        .get data: hash: hash
        .then ->
          eventBus.$emit 'user.list'
</script>

<style lang='scss'>
@import url('https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons');
@import '~vuetify/dist/vuetify.min.css';
@import '~@fortawesome/fontawesome-free/css/all.css';

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
