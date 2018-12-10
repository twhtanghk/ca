_ = require 'lodash'

module.exports =
  email:
    from: process.env.SMTP_FROM || 'admin@abc.com'
    msg: _.template """
        <html>
          <body>
            Please click <a href="<%=cbUrl%>">here</a> to verify your action for CA
          </body>
        </html>
      """
    opts:
      host: process.env.SMTP_HOST || 'smtp.abc.com'
      port: 25
      secure: false
