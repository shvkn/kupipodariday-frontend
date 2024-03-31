FROM node:16-alpine as builder
ARG API_SERVER_URL='http://localhost'
ENV NODE_ENV="production"
ENV REACT_APP_API_SERVER_URL $API_SERVER_URL
WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build

FROM nginx:latest
COPY --from=builder /app/build /usr/share/nginx/html
COPY --from=builder /app/.nginx/nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]
