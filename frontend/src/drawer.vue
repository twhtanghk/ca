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
{eventBus} = require('./lib').default

export default
  data: ->
    display: false
    items: [
      {
        title: 'List'
        icon: 'fas fa-list'
        action: @list
      }
      {
        title: 'Create Personal Certificate'
        icon: 'fas fa-user-shield'
        action: @create
      }
      {
        title: 'Enable 2 factor Authentication'
        icon: 'fas fa-user-lock'
        action: @otp
      }
    ]
  methods:
    hide: ->
      @display = false
    list: ->
      @hide()
      eventBus.$emit 'user.list'
    create: ->
      @hide()
      eventBus.$emit 'cert.create'
    otp: ->
      @hide()
      eventBus.$emit 'user.otp'
  created: ->
    eventBus.$on 'menu.click', =>
      @display = not @display
</script>
