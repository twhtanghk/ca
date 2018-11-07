# ca
CA Web App to issue personal certificate

## API

### User
get api/user/:id
  - get user details for specified id

put api/user/2fa
  - enable or disable 2 factor auth via parameter 'flag' true or f
alse
  - email verification with default 30 min validity (configured via env var validity) and callback url inclduing random hash

get api/user/2fa/verify/:hash
  - check validity interval
  - confirm enabling or disabling 2 factor auth

## Cert
```
get  api/cert/:email 
  - get personal cert for user with specified email

post api/cert
  - get private key with specified passphrase
