<script lang='coffee'>
Vue = require('vue').default
Vue.use require('vue.oauth2/src/plugin').default
Vue.use require('vue.model/src/plugin').default

export default
  User: new Vue
    extends: Vue.component 'model'
    props:
      baseUrl:
        default: 'api/user'
  Cert: new Vue
    extends: Vue.component 'model'
    props:
      baseUrl:
        default: 'api/cert'
</script>
