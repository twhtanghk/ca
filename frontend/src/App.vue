<template>
  <v-app>
    <drawer />
    <toolbar />
    <users />
  </v-app>
</template>

<script lang='coffee'>
Vue = require('vue').default
Vuetify = require 'vuetify'

Vue.use Vuetify

export default
  name: 'app'
  components:
    drawer: require('./drawer').default
    toolbar: require('./toolbar').default
    users: require('./content').default
</script>

<style lang='scss'>
@import url('https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons');
@import '~vuetify/dist/vuetify.min.css';

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
