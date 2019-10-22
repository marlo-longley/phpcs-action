#!/bin/bash
set -e

#phpcs --standard=Drupal .

phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md .