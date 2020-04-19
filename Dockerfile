FROM node:13.12.0-alpine AS build

WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

COPY package.json ./
COPY package-lock.json ./
RUN npm ci

COPY . ./
ENV BASE_URL /
RUN npm run build


FROM nginx:1.17-alpine AS runtime

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
