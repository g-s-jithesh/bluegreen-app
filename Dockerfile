FROM nginx:alpine
ARG COLOR=blue
COPY ${COLOR}.html /usr/share/nginx/html/index.html
