FROM php:7.3-cli
# Get tools
RUN apt-get update && apt-get -y install zip unzip git
# Install Drupal 8 code quality suite. Follows these instructions https://www.drupal.org/docs/8/modules/code-review-module/installing-coder-sniffer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && composer global require drupal/coder:^8.3.1  && composer global require dealerdirect/phpcodesniffer-composer-installer --no-plugins --no-scripts
ENV PATH="/root/.composer/vendor/bin:${PATH}"
RUN phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
#ENTRYPOINT phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md .
# Set the Dockerfile's entrypoint
COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]