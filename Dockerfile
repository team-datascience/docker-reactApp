#this used for production
# specify base images: Alpine Linux is a security-oriented, lightweight Linux distribution based on musllibc and busybox.
#specify the phase AS builder
FROM node:alpine  AS builder 
WORKDIR '/app'
COPY package.json  ./
RUN npm install
COPY . .
RUN npm run build
# run phase copy /app/build send to nginx server ,host static html content https://hub.docker.com/_/nginx
FROM nginx   
EXPOSE 80 
# WORKDIR /app
RUN pwd 
COPY --from=builder /app/build /usr/share/nginx/html
