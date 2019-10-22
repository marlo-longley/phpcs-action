GitHub Action for Drupal Coder + PHPCS
GitHub Action 

Usage
You can use it as a Github Action like this:

.github/main.workflow

workflow "PHP Linting" {
  resolves = ["Execute"]
  on = "pull_request"
}

action "Execute" {
  uses = "marlo-longley/phpcs-action@master"
}