# Step 1: Build Stage
FROM node:latest as build-stage

RUN apt-get update && apt-get install -y git

WORKDIR /app

RUN git clone https://github.com/jmalakauskas/todo-react.git /app

RUN yarn install

RUN yarn build

# Step 2: Serve application via Nginx
FROM nginx:alpine
# Copy built assets from build-stage to nginx's serve directory
COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]