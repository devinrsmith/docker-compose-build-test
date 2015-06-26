The `docker-compose build` doesn't seem to be obeying .dockerignore?

topdir and subdir get built as the same image, but subdir_app doesn't, I'm assuming because it's using a different build context that isn't respecting .dockerignore?

```
$ docker build -t topdir . && cd subdir && docker build -t subdir ../ && docker-compose build
Sending build context to Docker daemon 63.49 kB
Sending build context to Docker daemon 
Step 0 : FROM busybox
 ---> 8c2e06607696
Step 1 : COPY . /
 ---> 0b10606f8289
Removing intermediate container aa25bde33559
Step 2 : ENTRYPOINT /docker-entrypoint.sh
 ---> Running in f671cbea03cd
 ---> 5b534e4b3382
Removing intermediate container f671cbea03cd
Successfully built 5b534e4b3382
Sending build context to Docker daemon 63.49 kB
Sending build context to Docker daemon 
Step 0 : FROM busybox
 ---> 8c2e06607696
Step 1 : COPY . /
 ---> Using cache
 ---> 0b10606f8289
Step 2 : ENTRYPOINT /docker-entrypoint.sh
 ---> Using cache
 ---> 5b534e4b3382
Successfully built 5b534e4b3382
Building app...
Step 0 : FROM busybox
 ---> 8c2e06607696
Step 1 : COPY . /
 ---> 1fecc5a3f799
Removing intermediate container d3c01703aedc
Step 2 : ENTRYPOINT /docker-entrypoint.sh
 ---> Running in 3fcdfd4568bb
 ---> d407ef4017b7
Removing intermediate container 3fcdfd4568bb
Successfully built d407ef4017b7

$ docker images
REPOSITORY                TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
topdir                    latest              5b534e4b3382        3 seconds ago       2.447 MB
subdir                    latest              5b534e4b3382        3 seconds ago       2.447 MB
subdir_app                latest              d407ef4017b7        3 seconds ago       2.447 MB
busybox                   latest              8c2e06607696        9 weeks ago         2.43 MB

$ docker run --rm -it topdir
ls: /subdir: No such file or directory

$ docker run --rm -it subdir
ls: /subdir: No such file or directory

$ docker run --rm -it subdir_app
drwxr-xr-x    2 root     root          4096 Jun 26 20:55 /subdir
```

```
$ docker info
Containers: 9
Images: 99
Storage Driver: overlay
 Backing Filesystem: extfs
Execution Driver: native-0.2
Logging Driver: json-file
Kernel Version: 4.0.5-x86_64-linode58
Operating System: Debian GNU/Linux 7 (wheezy)
CPUs: 4
Total Memory: 3.858 GiB
Name: vesper
ID: 627D:F7VS:4P37:O7FP:LTRI:YABQ:ND2Q:676N:NAFD:UZIY:SHDQ:KKEW
WARNING: No memory limit support
WARNING: No swap limit support

$ docker-compose --version
docker-compose version: 1.3.1
CPython version: 2.7.9
OpenSSL version: OpenSSL 1.0.1e 11 Feb 2013

$ docker --version
Docker version 1.7.0, build 0baf609
```
