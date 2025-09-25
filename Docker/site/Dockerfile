FROM node:lts-bookworm AS dependencies
WORKDIR /
COPY ./oberon/Oberon-Aplicacao-Web/package.json .
RUN npm install

FROM node:lts-alpine3.20 AS deploy
WORKDIR /
COPY --from=dependencies ./node_modules ./node_modules
COPY ./oberon/Oberon-Aplicacao-Web .
EXPOSE 80
CMD [ "node", "app.js" ]
