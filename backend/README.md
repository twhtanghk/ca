# ca
CA Web App to issue personal certificate

## API

### User
get api/user
  - get user list

get api/user/:id
  - get user details for specified id

put api/user/otp
  - enable or disable 2 factor auth by One Time Password via parameter 'enable'
  - email verification with default 30 min validity (configured via env var validity) and callback url inclduing random hash

get api/user/verify/:hash
  - check validity interval
  - confirm enabling or disabling 2 factor auth

get api/user/:id/qrcode

### Cert
post api/cert
  - create private/public key, and certificate

delete api/cert/:id
  - revoke the certificate with parameters id and revokedReason
