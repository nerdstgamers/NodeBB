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

EXPOSE 8080

CMD node loader.js --no-daemon
