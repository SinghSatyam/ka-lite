#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or use sudo" 
   exit 1
fi

if [ "$#" -ne 1 ]
then
  echo "You need to pass the logged in username."
  exit 1
fi

echo "Removing default nginx configuration."
rm -rf /etc/nginx/sites-enabled/default
rm -rf /etc/nginx/sites-available/default
echo "Removal done."
echo "Configuring NGINX with $1 user..."
echo 'upstream kalite {
    server 127.0.0.1:9500;
}

server {

    listen 8008;

    location /static {
        alias   /home/'$1'/.kalite/httpsrv/static/;
    }

    location /media {
        alias   /home/'$1'/.kalite/media/;
    }

    location /content {
        alias   /home/'$1'/.kalite/content/;
    }

    location /favicon.ico {
        empty_gif;
    }

    location / {
        proxy_set_header Host $http_host;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_pass http://kalite;
        error_page 502 = @502;
    }

    location @502 {
        types { }
        default_type "text/html";
        return 502 "
        <BR>
        <H1>KA-Lite might be busy - wait a few moments and then reload this page
        <BR><BR>
        <H2>If KA-Lite is still busy, get help from the system administrator
        <H3>Error code: nginx 502 Bad Gateway (maybe the KA-Lite webserver is not working correctly)";
    }

}' > /etc/nginx/sites-enabled/default
echo 'upstream kalite {
    server 127.0.0.1:9500;
}

server {

    listen 8008;

    location /static {
        alias   /home/'$1'/.kalite/httpsrv/static/;
    }

    location /media {
        alias   /home/'$1'/.kalite/media/;
    }

    location /content {
        alias   /home/'$1'/.kalite/content/;
    }

    location /favicon.ico {
        empty_gif;
    }

    location / {
        proxy_set_header Host $http_host;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_pass http://kalite;
        error_page 502 = @502;
    }

    location @502 {
        types { }
        default_type "text/html";
        return 502 "
        <BR>
        <H1>KA-Lite might be busy - wait a few moments and then reload this page
        <BR><BR>
        <H2>If KA-Lite is still busy, get help from the system administrator
        <H3>Error code: nginx 502 Bad Gateway (maybe the KA-Lite webserver is not working correctly)";
    }

}' > /etc/nginx/sites-available/default
echo "Nginx is configured with $1 user..."

service nginx start

