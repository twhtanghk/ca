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
  Cert: new Vue
    extends: Vue.component 'model'
    props:
      baseUrl:
        default: 'api/cert'
      eventBus:
        default: eventBus
</script>
