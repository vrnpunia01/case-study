FROM nginx:alpine

COPY --from=build-deps /usr/src/front/public /usr/share/nginx/html
COPY casestudy.com.conf /etc/nginx/conf.d/
COPY cert.pem /etc/ssl/certs/
COPY key.pem /etc/ssl/certs/
