FROM php:7.3-cli
# Set up the Action
LABEL "com.github.actions.name"="Drupal Coder + PHPCS"
# See https://www.drupal.org/project/coder
LABEL "com.github.actions.description"="Runs Drupal code quality tools with PHPCS on pull requests."
# Github Actions supports Feather icons to customize your look: https://feathericons.com/
# Droplet for Drupal
LABEL "com.github.actions.icon"="droplet"
LABEL "com.github.actions.color"="pink"
LABEL version="1.0.0"
LABEL repository="https://github.com/marlo-longley/phpcs-action"
LABEL homepage="https://github.com/marlo-longley/phpcs-action"
LABEL maintainer="Marlo Longley <marlo@codeandcursor.com>"
# Get tools
RUN apt-get update && apt-get -y install zip unzip git
# Install Drupal 8 code quality suite. Follows these instructions https://www.drupal.org/docs/8/modules/code-review-module/installing-coder-sniffer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && composer global require drupal/coder:^8.3.1  && composer global require dealerdirect/phpcodesniffer-composer-installer --no-plugins --no-scripts
ENV PATH="/root/.composer/vendor/bin:${PATH}"
RUN phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
# Set the Dockerfile's entrypoint
COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]