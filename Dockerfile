FROM ubuntu:20.04
LABEL maintainer="PetarVasilev"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y nginx
EXPOSE 80
CMD [ "/usr/sbin/nginx","-g","daemon off;" ]
COPY . /var/www/html
