<template>
  <v-toolbar color='primary' dark>
    <v-toolbar-side-icon @click.stop='menuClick'></v-toolbar-side-icon>
    <v-toolbar-title class="white--text">CA</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn icon>
      <font-awesome-icon icon='search' class='fa-fw fa-inverse' />
    </v-btn>
    <user />
  </v-toolbar>
</template>

<script lang='coffee'>
{eventBus} = require('./lib').default
{User} = require('./model').default

export default
  components:
    user: require('./user').default
  methods: 
    menuClick: ->
      eventBus.$emit 'menu.click'
</script>
