FROM alpine:3.10
# Get tools
#RUN apt-get update && apt-get -y install zip unzip git

# Install Drupal 8 code quality suite. Follows these instructions https://www.drupal.org/docs/8/modules/code-review-module/installing-coder-sniffer
RUN composer global require drupal/coder:^8.3.1  && composer global require dealerdirect/phpcodesniffer-composer-installer --no-plugins --no-scripts

# Most tools we need are included on the github action virtual machines, no need to install
# See https://help.github.com/en/github/automating-your-workflow-with-github-actions/software-in-virtual-environments-for-github-actions
ENV PATH="~/.composer/vendor/bin:${PATH}"
RUN phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
#ENTRYPOINT phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md .
# Set the Dockerfile's entrypoint
COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]