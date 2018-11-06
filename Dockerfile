FROM node

ENV APP=/usr/src/app
ADD . $APP

WORKDIR $APP

RUN (cd backend; yarn install)

EXPOSE 1337

CMD cd backend && npm start
