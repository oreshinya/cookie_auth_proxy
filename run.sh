envsubst '$$BASIC_SECRET $$COOKIE_SECRET $$BACKEND_URL' < $HOME/nginx/conf/nginx.conf.template > $HOME/nginx/conf/nginx.conf
$HOME/nginx/sbin/nginx -g "daemon off;"
