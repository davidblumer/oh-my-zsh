# Symfony2 basic command completion

_symfony_console () {
  echo "php $(find . -maxdepth 2 -mindepth 1 -name 'console' -type f | head -n 1)"
}

_symfony2_get_command_list () {
   `_symfony_console` --no-ansi | sed "1,/Available commands/d" | awk '/^  ?[^ ]+ / { print $1 }'
}

_symfony2 () {
   compadd `_symfony2_get_command_list`
}

compdef _symfony2 '`_symfony_console`'
compdef _symfony2 'app/console'
compdef _symfony2 'bin/console'
compdef _symfony2 sf

#Alias
alias sf='`_symfony_console`'
alias sfcl='sf cache:clear'
alias sfsr='sf server:run -vvv'
alias sfcw='sf cache:warmup'
alias sfroute='sf router:debug'
alias sfcontainer='sf container:debug'
alias sfgb='sf generate:bundle'
alias sfclnw='sf cache:clear --no-warmup'
alias sfsr='sf server:run'
alias sfaw='sf assetic:watch'
alias sfad='sf assetic:dump'
alias schemau='sf doctrine:schema:update --force'
alias schemav='sf doctrine:schema:validate'
alias snapshot='sf sonata:page:create-snapshot --site=all'
alias routes='sf sonata:page:update-core-routes --site=all'
alias fixtures='sf doctrine:fixtures:load'
alias fix='sfclnw; routes; snapshot'
alias deploy='composer install; sfcl; sfad; sf assets:install; routes; snapshot; sf sbdeploy'
alias ddr='sf doctrine:database:drop --force --no-interaction; sf doctrine:database:create; sf doctrine:migration:migrate --no-interaction; sf doctrine:fixtures:load --no-interaction'
alias cache='rm -fr app/cache/de*'