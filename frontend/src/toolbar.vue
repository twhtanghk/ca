<template>
  <v-toolbar color='primary' dark>
    <v-toolbar-title class="white--text">CA</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn icon @click='toggle'>
      <v-icon>search</v-icon>
    </v-btn>
    <v-text-field @click:append='toggle' append-icon='close' autofocus solo-inverted single-line v-if='show' v-model='text' @input='search' />
    <user />
  </v-toolbar>
</template>

<script lang='coffee'>
{eventBus} = require('./lib').default
{User} = require('./model').default

export default
  components:
    user: require('./user').default
  data: ->
    text: ''
    show: false
  methods:
    search: ->
      eventBus.$emit 'search', @text
    toggle: ->
      @show = not @show
      if not @show
        @text = ''
        @search()
</script>
