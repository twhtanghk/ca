FROM node

ENV APP=/usr/src/app
ADD . $APP

WORKDIR $APP

RUN yarn install \
&&  sed 's/demoCA/data/g' </etc/ssl/openssl.cnf >/tmp/$$ \
&&  mv /tmp/$$ /etc/ssl/openssl.cnf

EXPOSE 1337

ENTRYPOINT ["npm", "start"]
