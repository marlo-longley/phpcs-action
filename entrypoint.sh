#!/bin/bash
set -e

echo "I'm in the entrypoint"
phpcs -i
phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md ./
