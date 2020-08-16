FROM node:lts

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

COPY install/package.json /usr/src/app/package.json

RUN npm install --only=prod && \
    npm cache clean --force
    
COPY . /usr/src/app

RUN node build-config.js

ENV NODE_ENV=production \
    daemon=false \
    silent=false

EXPOSE 4567

CMD node ./nodebb activate nodebb-plugin-write-api;node ./nodebb activate nodebb-plugin-session-sharing; node ./nodebb build ;  node ./nodebb start
