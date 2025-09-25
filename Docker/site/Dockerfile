FROM node:lts-bookworm AS dependencies
WORKDIR /app

COPY ./web-site/package*.json ./

RUN npm install

FROM node:lts-alpine3.20 AS deploy
WORKDIR /app

COPY --from=dependencies /app/node_modules ./node_modules

COPY ./web-site .

EXPOSE 80

CMD [ "node", "app.js" ]