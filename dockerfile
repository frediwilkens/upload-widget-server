FROM node:22.16 AS dependencies

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm ci

FROM dependencies AS build

WORKDIR /usr/src/app

COPY . .
COPY --from=dependencies /usr/src/app/node_modules ./node_modules

RUN npm run build
RUN npm prune --prod

FROM node:22.16-alpine AS deploy

WORKDIR /usr/src/app

USER 1000

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package.json ./package.json

EXPOSE 3333

CMD ["dist/infra/http/server.js"]