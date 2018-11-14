<template>
  <v-toolbar color='primary'>
    <v-toolbar-side-icon @click='menuClick'></v-toolbar-side-icon>
    <v-toolbar-title class="white--text">CA</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn icon>
      <v-icon>search<v-icon>
    </v-btn>
  </v-toolbar>
</template>

<script lang='coffee'>
{eventBus} = require('./lib').default

export default
  methods: 
    menuClick: ->
      eventBus.$emit 'menu.click'
</script>
