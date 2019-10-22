FROM php:7.3-cli

LABEL "com.github.actions.name"="Drupal Coder + PHPCS"
# See https://www.drupal.org/project/coder
LABEL "com.github.actions.description"="Runs Drupal code quality tools with PHPCS on pull requests."
# Github Actions supports Feather icons to customize your look: https://feathericons.com/
# Picked droplet for Drupal
LABEL "com.github.actions.icon"="droplet"
LABEL "com.github.actions.color"="pink"

LABEL version="1.0.0"
LABEL repository="https://github.com/marlo-longley/phpcs-action"
LABEL homepage="https://github.com/marlo-longley/phpcs-action"
LABEL maintainer="Marlo Longley <marlo@codeandcursor.com>"

RUN apt-get update && apt-get -y install zip unzip git

# Install composer using latest signature
# See https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
#RUN EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#RUN ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"
#RUN if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then \
#    >&2 echo 'ERROR: Invalid installer signature' \
#    rm composer-setup.php \
#    exit 1; \
#    fi
#RUN php composer-setup.php
#RUN RESULT=$?
#RUN rm composer-setup.php
#RUN exit $RESULT
# move the composer file
#RUN mv composer.phar /usr/local/bin/composer

# Install Drupal 8 code quality tools. Follows these instructions https://www.drupal.org/docs/8/modules/code-review-module/installing-coder-sniffer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && composer global require drupal/coder:^8.3.1  && composer global require dealerdirect/phpcodesniffer-composer-installer --no-plugins --no-scripts
ENV PATH="/root/.composer/vendor/bin:${PATH}"
RUN phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
RUN phpcs -i

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]