_ = require 'lodash'

module.exports =
  email:
    from: 'admin@abc.com'
    msg: _.template """
        <html>
          <body>
            Please click <a href="<%=cbUrl%>">here</a> to #{action} for CA
          </body>
        </html>
      """
    opts:
      host: 'smtp.abc.com'
      port: 25
      secure: false
