# http://example.com/
server {
    listen 80;
    listen [::]:80;
    server_name euclidpoint.com euclidpoint;
    root /var/www/euclidpoint.com;
}

# http://www.example.com/ => http://example.com/
server {
    listen 80;
    listen [::]:80;
    server_name www.euclidpoint.com;
    return 301 http://euclidpoint.com$request_uri;
}
