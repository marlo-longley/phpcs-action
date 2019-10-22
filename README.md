GitHub Action for Drupal Coder + PHPCS
GitHub Action 

Usage
You can use it as a Github Action like this:

.github/workflows/phpcs.yml

name: Drupal Coder + PHPCS
# This workflow is triggered on pull requests to the repository.
on: [pull_request]
jobs:
  build:
    # Job name is PHPCS
    name: PHPCS
    # This job runs on Linux
    runs-on: ubuntu-latest
    steps:
      - name: Drupal Coder + PHPCS
        uses: marlo-longley/phpcs-action@master
        id: phpcs
