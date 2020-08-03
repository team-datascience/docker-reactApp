#this used for production
# specify base images: Alpine Linux is a security-oriented, lightweight Linux distribution based on musllibc and busybox.
#specify the phase AS builder
FROM node:alpine  AS builder 
WORKDIR /app
COPY package.json  .
RUN npm install
COPY . .
RUN npm run build
EXPOSE 80
# run phase copy /app/build send to nginx server ,host static html content https://hub.docker.com/_/nginx
FROM nginx   
WORKDIR /app
COPY --from=builder /app/build /usr/share/nginx/html
