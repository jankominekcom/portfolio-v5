FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app/build build/

COPY package.json .

RUN npm install --omit=dev
RUN npm prune --production

EXPOSE 3000

ENV NODE_ENV=production

CMD [ "node", "build" ]
