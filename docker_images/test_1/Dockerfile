FROM nginx:1.21.3

RUN apt-get update 

WORKDIR /app

RUN rm /etc/nginx/conf.d/default.conf
RUN mkdir -p /var/www/amogus/music
RUN mkdir -p /var/www/amogus/images
COPY amogus.png /var/www/amogus/images/amogus.png
COPY music.mp3 /var/www/amogus/music/music.mp3
#=================================================

COPY fullchain.pem /etc/nginx/certs/fullchain.pem
COPY privkey.pem /etc/nginx/certs/privkey.pem
COPY options-ssl.conf /etc/nginx/certs/options-ssl-nginx.conf
COPY ssl-dhparams.pem /etc/nginx/certs/ssl-dhparams.pem

#=================================================
COPY index.html /var/www/amogus/html/index.html
COPY secondpage.html /var/www/amogus/html/secondpage.html
COPY amogus.conf /etc/nginx/conf.d/amogus.conf

EXPOSE 80
EXPOSE 443
