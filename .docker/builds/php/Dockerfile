FROM php:8.3.10-fpm

ENV user dev
ARG PUID=1000
ARG PGID=1000
#COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
# Install composer
COPY --from=composer:2.4 /usr/bin/composer /usr/bin/
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="./vendor/bin:$PATH"

RUN groupadd -g $PGID $user \
  && useradd -u $PUID -g $user -m $user \
  && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y --no-install-recommends \
        gnupg \
		libzip-dev \
    	libxml2-dev \
    	libssl-dev \
        nodejs \
        yarn \
    	libcurl4-openssl-dev \
    	libxslt1-dev

RUN pecl install redis
RUN pecl install raphf && docker-php-ext-enable raphf
RUN pecl install pecl_http && docker-php-ext-enable http

RUN docker-php-ext-install pdo_mysql zip bcmath intl
RUN docker-php-ext-enable redis

RUN pecl clear-cache

USER $user

