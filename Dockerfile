FROM nginx:24-alpine

COPY . /usr/share/nginx/html

EXPOSE 80