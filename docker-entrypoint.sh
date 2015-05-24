#!/bin/bash

set -e


function defaults {
    : ${PHP_TIMEZONE:=UTC}

    echo "PHP_TIMEZONE is ${PHP_TIMEZONE}"

    export PHP_TIMEZONE
}

defaults

if [ "$1" = 'supervisord' ]; then
    echo "[Run] supervisord"

    # Note: PHP_TIMEZONE needs to be escaped to play nice with sed
    sed -i "s/;date.timezone =/date.timezone = \"${PHP_TIMEZONE}\"/" /etc/php5/apache2/php.ini

    /usr/bin/supervisord -c /etc/supervisor/supervisord.conf -n
    exit 0
fi

echo "[RUN]: Builtin command not provided [supervisord]"
echo "[RUN]: $@"

exec "$@"
