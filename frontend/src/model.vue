<script lang='coffee'>
Vue = require('vue').default
Vue.use require('vue.oauth2/src/plugin').default
Vue.use require('vue.model/src/plugin').default
{eventBus} = require('./lib').default

export default
  User: new Vue
    extends: Vue.component 'model'
    props:
      baseUrl:
        default: 'api/user'
      eventBus:
        default: eventBus
    methods:
      format: (data) ->
        data.createdAt = new Date data.createdAt
        data.updatedAt = new Date data.updatedAt
        if 'certs' of data
          for cert in data.certs
            cert.createdAt = new Date cert.createdAt
            cert.updatedAt = new Date cert.updatedAt
            cert.dtStart = new Date cert.dtStart
            cert.dtEnd = new Date cert.dtEnd
        data
      me: ->
        await @read data: id: 'me'
  Cert: new Vue
    extends: Vue.component 'model'
    props:
      baseUrl:
        default: 'api/cert'
      eventBus:
        default: eventBus
  Action: new Vue
    extends: Vue.component 'model'
    props:
      baseUrl:
        default: 'api/action'
      eventBus:
        default: eventBus
</script>
