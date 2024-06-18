FROM squidfunk/mkdocs-material:latest as BUILDER
WORKDIR /app
COPY mkdocs.yml /app/mkdocs.yml
COPY docs /app/docs
RUN ["mkdocs", "build"]

FROM nginx:stable-alpine3.17-slim
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=BUILDER /app/site /var/www/documentation
HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1"
EXPOSE 80
