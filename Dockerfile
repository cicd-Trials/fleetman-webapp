FROM nginx:1.21.1-alpine

MAINTAINER Richard Chesterwood "richard@inceptiontraining.co.uk"

RUN apk --no-cache add \
      python2 \
      py-pip && \
    pip install j2cli[yaml]

RUN apk add --update bash && rm -rf /var/cache/apk/*

RUN rm -rf /usr/share/nginx/html/*

RUN rm /etc/nginx/conf.d/default.conf

COPY content /usr/share/nginx/html

COPY conf /etc/nginx

# COPY /dist /usr/share/nginx/html

COPY nginx.conf.j2 /templates/

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
