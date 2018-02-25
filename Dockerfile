FROM node:8-alpine

ENV NODE_ENV production
# this will enable polling, hot-reload will work on docker or network volumes
ENV CHOKIDAR_USEPOLLING true

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN npm install express-gateway@1.7.2 && \
    ./node_modules/.bin/eg gateway create -n gateway -d . -t getting-started && \
    npm cache clean --force && \
    ./node_modules/.bin/eg plugin install express-gateway-plugin-rewrite -n -g
COPY gateway.config.yml ./config/gateway.config.yml 

EXPOSE 8080

CMD [ "npm", "run", "start" ]
