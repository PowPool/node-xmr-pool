# How to setup SSL with letsencrypt


This is basic how-to for SSL setup which will cover API and WEB frontend (nginx in that case) on ubuntu 16.04 with help of letsencrypt

Prereq:
  - you have nginx installed
  - you have bc installed
  - you have prepared environment for pool itself (nodejs & comp)

Download letsencrypt and generate certs for your domain:
```sh
$ git clone https://github.com/letsencrypt/letsencrypt /opt/services/letsencrypt
$ cd /opt/services/letsencrypt
$ ./certbot-auto certonly --standalone -d YOURDOMAIN
```


Copy those certs also to the directory, where your nodejs sumo pool is and change the ownership for them so your user you are using for running nodejs can read them and use them for API:
```sh
$ cp /etc/letsencrypt/live/YOURDOMAIN/cert.pem /INSTALLATION-PATH-OF-NODEJS-POOL/
$ cp /etc/letsencrypt/live/YOURDOMAIN/privkey.pem /INSTALLATION-PATH-OF-NODEJS-POOL/
$ chown USER:GROUP /INSTALLATION-PATH-OF-NODEJS-POOL/*.pem
```

Make sure that you changed your ssl cert settings in pool's json config to:

```sh
"sslKey": "privkey.pem",
"sslCert": "cert.pem",
```

For nginx you have to create site config and use those certs for https. You can find nginx-ssl-example.com as example config for your site in root of this repo.

If you want to have certs automatically renewed from letsencrypt CA, you can write cron rule:

```sh
$ sudo crontab -e

# Add this to the crontab and save it:
* 7,19 * * * certbot -q renew
```

This will regenerate your certs in /etc/letsencrypt/live/YOURDOMAIN/ so you still have to copy them to your nodejs pool directory and change ownership, or write script which will do it automatically for you.


