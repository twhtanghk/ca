<template>
  <v-navigation-drawer v-model='display' fixed temporary>
    <v-list>
      <v-list-tile v-for='item in items' :key='item.title' @click='item.action'>
        <v-list-tile-action>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title>{{ item.title }}</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </v-navigation-drawer>
</template>

<script lang='coffee'>
eventBus = require('vue.oauth2/src/eventBus').default

list =
  title: 'list'
  icon: 'view_list'
  action: ->
    return

export default
  data: ->
    display: false
    items: [
      list
    ]
  created: ->
    eventBus.$on 'menu.click', =>
      @display = not @display
</script>
