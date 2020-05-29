FROM nginx:alpine
RUN apk update && apk add bash bind-tools busybox-extras
COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
