FROM mediawiki:1.46.2

# install deps
RUN apt-get update && apt-get install -y \
  libonig-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libjpeg-dev \
  libmcrypt-dev \
  libmemcached-dev \
  libpng-dev \
  libpq-dev \
  sendmail

# add php extensions
RUN docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql pdo_pgsql pgsql

# add mediawiki extensions
COPY extensions/AuthMinetest /var/www/html/extensions/AuthMinetest
RUN cd /var/www/html/extensions/ &&\
  git clone --depth=1 https://github.com/wikimedia/mediawiki-extensions-MsUpload MsUpload  -b REL1_46 &&\
  git clone --depth=1 https://github.com/ProfessionalWiki/SimpleBatchUpload -b 4.0.0 &&\
  git clone --depth=1 https://github.com/cmln/mw-font-awesome/ -b 4.1.0 FontAwesome &&\
  git clone --depth=1 https://github.com/kulttuuri/DiscordNotifications.git -b 1.14

COPY php.ini $PHP_INI_DIR/conf.d/custom.ini
COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
