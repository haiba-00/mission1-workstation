FROM nginx:alpine
LABEL org.opencontainers.image.title="haiba-00-mission1"
ENV APP_ENV=practice
COPY web/ /usr/share/nginx/html/
EXPOSE 80
