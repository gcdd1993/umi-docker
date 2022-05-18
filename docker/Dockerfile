FROM nginx:1.21.6-alpine

ARG DIST_DIR
WORKDIR /data

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY $DIST_DIR /data

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
