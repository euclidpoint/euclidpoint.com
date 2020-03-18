# https://example.com/
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name euclidpoint.com euclidpoint;

    ssl_certificate /etc/letsencrypt/live/euclidpoint.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/euclidpoint.com/privkey.pem;

    root /var/www/euclidpoint.com;
}

# https://www.example.com/ => https://example.com/
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name www.euclidpoint.com;

    ssl_certificate /etc/letsencrypt/live/euclidpoint.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/euclidpoint.com/privkey.pem;

    return 301 https://euclidpoint.com$request_uri;
}

# http://example.com/, http://www.example.com/ => https://example.com/
server {
    listen 80;
    listen [::]:80;
    server_name euclidpoint.com www.euclidpoint.com;
    return 301 https://euclidpoint.com$request_uri;
}
