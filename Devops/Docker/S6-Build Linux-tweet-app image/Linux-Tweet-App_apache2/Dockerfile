FROM ubuntu:latest
RUN apt-get update -y
RUN apt install -y apache2 
RUN apt install -y apache2-utils
COPY index.html /var/www/html
EXPOSE 8080

CMD ["apache2ctl", "-D", "FOREGROUND"]