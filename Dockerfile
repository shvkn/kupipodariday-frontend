FROM node:16-alpine as builder
ARG API_SERVER_URL='http://localhost'
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
ENV REACT_APP_API_SERVER_URL $API_SERVER_URL
RUN npm run build

FROM nginx:latest
COPY --from=builder /app/build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
