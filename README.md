# Automated Docker build for Apache2, PHP5 and Extensions

* Based on/uses the official [Debian Docker image](https://hub.docker.com/_/debian/).
* Enabled extensions: curl, gd, mcrypt, mysql, redis and apcu.
* Includes vhosts.conf file for dynamic VirtualHosts*.
* Disables *000-default.conf*.

\* Meaning you can create a new website by simply creating a new folder in the webroot. No re-configuration of Apache or .conf file needed.

## Configuring vhosts.conf

Be sure to replace 'YOUR_DOMAIN_NAME_GOES_HERE' with your actual domain name.

## Creating an Image

```bash
docker build -t apache-php:latest .
````

## Creating a Container

```bash
docker run -d --name apache-php -p 0.0.0.0:1080:80 apache-php:latest
````

Accessible via:

```
http://domain-or-docker-host-ip:1080
```

Which should present you with the message:

```
APACHE with PHP on Docker is up and running...
```

## Persistent Storage

```bash
docker run -d --name apache-php -p 0.0.0.0:1080:80 --volume /your/desired/local/webroot:/var/www apache-php:latest
```

## Persistent Storage & Linking (MySQL)

```bash
docker run -d --name apache-php -p 0.0.0.0:1080:80 --link mysql:mysql --volume /your/desired/local/webroot:/var/www apache-php:latest
```
