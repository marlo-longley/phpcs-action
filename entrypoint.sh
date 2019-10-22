#!/bin/bash
set -e

#phpcs --standard=Drupal .

echo "I'm in the entrypoint"
phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md .