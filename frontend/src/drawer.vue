<template>
  <v-navigation-drawer v-model='display' fixed temporary>
    <v-list>
      <v-list-tile v-for='item in items' @click='item.action'>
        <v-list-tile-avatar>
          <font-awesome-icon :icon='item.icon' />
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title>
            {{ item.title }}
          </v-list-title-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-switch v-model="item.enable" v-if='"enable" in item' @change='item.action($event, item.enable)'/>
        </v-list-tile-action>
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
        icon: 'list'
        action: @list
      }
      {
        title: 'Create Personal Certificate'
        icon: 'user-shield'
        action: @create
      }
      {
        title: 'Enable 2 Factor Auth'
        icon: 'user-lock'
        action: @otp
        enable: false
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
    otp: (event, enable) ->
      @hide()
      eventBus.$emit 'user.otp', enable: enable
  created: ->
    eventBus.$on 'menu.click', =>
      @display = not @display
</script>
