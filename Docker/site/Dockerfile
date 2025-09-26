FROM node:lts-bookworm AS dependencies
WORKDIR /app

# CORREÇÃO 1: Incluir a pasta raiz do projeto no caminho
# (Para que funcione com o contexto da Home)
COPY ./Oberon-Config-AWS/web-site/package*.json ./

RUN npm install

FROM node:lts-alpine3.20 AS deploy
WORKDIR /app

COPY --from=dependencies /app/node_modules ./node_modules

COPY ./oberon/Oberon-Aplicacao-Web .

EXPOSE 80

CMD [ "node", "app.js" ]