# HTTP — redirect all traffic to HTTPS
server {
    listen 80;
    listen [::]:80 default_server ipv6only=on;
    server_name YOURDOMAIN;
    return 301 https://$host$request_uri;
}

# HTTPS — proxy all requests to the Node app
server {
    # Enable HTTP/2
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name YOURDOMAIN;

    # Use the Let’s Encrypt certificates
    ssl_certificate /etc/letsencrypt/live/YOURDOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/YOURDOMAIN/privkey.pem;

    # Include the SSL configuration from cipherli.st
    include snippets/ssl-params.conf;

    location / {
	root /opt/www/YOURDOMAIN;
    	index index.html;
    }
    location /api {
        rewrite_log on;
	rewrite ^/api$ /api/ redirect;
	rewrite /api(.*) $1 break;
# THESE ARE IMPORTANT
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
# This is what tells Connect that your session can be considered secure,
# even though the protocol node.js sees is only HTTP:
	proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;
        proxy_read_timeout 5m;
        proxy_connect_timeout 5m;
        proxy_pass http://YOURDOMAIN:8118;
        proxy_redirect off;
     }
}
