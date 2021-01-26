# Moskvich webserver docker image
This webserver image is created specifically for the private Moskvich server.
It will most likely work anywhere else. _Refer to mount paths._

Based on **Ubuntu 20.04**

### Building
Building is straightforward
```sh
docker build -t <imagename> <path>
```

### Deployment
This Docker image uses quite a bit of hot mounting for persistence of modifyable directories and configuration files. 
**Please set up permissions carefully to avoid potential security risks!** `755 rwx-rx-rx` is sufficient for `/var/www` with writable directories mounted as `775 rwx-rwx-rx` with group set to something unique, like `web-admin`.

**Runing**:
```sh
docker run -t -d \
-p 80:80 \
-p 443:443 \
-m <size> \
-v <www_root>:/var/www/ \
-v <letsencrypt_root>:/etc/letsencrypt/ \
-v <hosts_root>:/etc/nginx/sites-enabled/ \
--restart unless-stopped --name <container_name> <imagename>
```
[More information about the commandline here](https://docs.docker.com/engine/reference/commandline/run/)
