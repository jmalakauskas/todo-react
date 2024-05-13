# Step 1: Build Stage
FROM node:latest as build-stage

WORKDIR /app
COPY . .
RUN yarn install && yarn build

# Step 2: Serve application via Nginx
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=build-stage /app/dist .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]