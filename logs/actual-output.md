## Docker 버전
```text
> docker --version
Docker version 29.9.2, build a82e528
Exit code: 0
```

## Docker 데몬 실제 출력
```text
> docker info --format ServerVersion={{.ServerVersion}}; OSType={{.OSType}}; Driver={{.Driver}}; Containers={{.Containers}}; Images={{.Images}}
ServerVersion=29.9.2; OSType=linux; Driver=overlayfs; Containers=19; Images=8
Exit code: 0
```

## hello-world 전체 실행 출력
```text
> docker run --rm hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
Exit code: 0
```

## Ubuntu 터미널 조작 및 권한 전후
```text
> docker run --rm ubuntu:24.04 bash -lc mkdir -p /practice/demo; cd /practice; pwd; ls -la; touch empty.txt; echo hello > original.txt; cp original.txt copy.txt; mv copy.txt renamed.txt; cat renamed.txt; rm renamed.txt; chmod 644 empty.txt; chmod 755 demo; echo BEFORE; ls -ld empty.txt demo; chmod 600 empty.txt; chmod 700 demo; echo AFTER; ls -ld empty.txt demo
/practice
total 12
drwxr-xr-x 3 root root 4096 Nov 15 06:14 .
drwxr-xr-x 1 root root 4096 Nov 15 06:14 ..
drwxr-xr-x 2 root root 4096 Nov 15 06:14 demo
hello
BEFORE
drwxr-xr-x 2 root root 4096 Nov 15 06:14 demo
-rw-r--r-- 1 root root    0 Nov 15 06:14 empty.txt
AFTER
drwx------ 2 root root 4096 Nov 15 06:14 demo
-rw------- 1 root root    0 Nov 15 06:14 empty.txt
Exit code: 0
```

## Docker 이미지 실제 목록
```text
> docker images haiba00-mission1
IMAGE                       ID             DISK USAGE   CONTENT SIZE   EXTRA
haiba00-mission1:1.0        bd76ec41ade5       93.7MB         26.4MB   U    
haiba00-mission1:verified   39484e55d44b       93.7MB         26.4MB
Exit code: 0
```

## Docker 컨테이너 실제 목록
```text
> docker ps -a --filter name=haiba00-
CONTAINER ID   IMAGE                  COMMAND                  CREATED          STATUS                        PORTS                                       NAMES
89b479c2aeb5   haiba00-mission1:1.0   "/docker-entrypoint.…"   22 minutes ago   Up 22 minutes                 0.0.0.0:18083->80/tcp, [::]:18083->80/tcp   haiba00-m1-final-bind
5d9d2c413e85   haiba00-mission1:1.0   "/docker-entrypoint.…"   22 minutes ago   Up 22 minutes                 0.0.0.0:18082->80/tcp, [::]:18082->80/tcp   haiba00-m1-final-web
a521b818f7ce   ubuntu:24.04           "sleep infinity"         22 minutes ago   Exited (137) 22 minutes ago                                               haiba00-m1-final-linux
bec8e44cdf8a   ubuntu:24.04           "bash -lc 'sleep 3; …"   27 minutes ago   Exited (0) 26 minutes ago                                                 haiba00-m1-attach
6031bfd6c55e   65a57a846e81           "/docker-entrypoint.…"   38 minutes ago   Up 38 minutes                 0.0.0.0:18081->80/tcp, [::]:18081->80/tcp   haiba00-m1-bind
a105d9fdebf3   65a57a846e81           "/docker-entrypoint.…"   38 minutes ago   Up 38 minutes                 0.0.0.0:18080->80/tcp, [::]:18080->80/tcp   haiba00-m1-web
6ee057c9cc67   ubuntu:24.04           "sleep infinity"         39 minutes ago   Up 38 minutes                                                             haiba00-m1-linux
Exit code: 0
```

## Dockerfile 빌드 전체 로그
```text
> docker build --progress=plain -t haiba00-mission1:verified .
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 178B done
#1 DONE 0.1s

#2 [internal] load metadata for docker.io/library/nginx:alpine
#2 DONE 0.2s

#3 [internal] load .dockerignore
#3 transferring context: 60B done
#3 DONE 0.1s

#4 [internal] load build context
#4 transferring context: 59B done
#4 DONE 0.0s

#5 [1/2] FROM docker.io/library/nginx:alpine@sha256:713fc2ebfd92e8217db451477182ee91944b123d2b1ee9fd5a8c6e91ca6c3a11
#5 resolve docker.io/library/nginx:alpine@sha256:713fc2ebfd92e8217db451477182ee91944b123d2b1ee9fd5a8c6e91ca6c3a11 0.1s done
#5 DONE 0.1s

#6 [2/2] COPY web/ /usr/share/nginx/html/
#6 CACHED

#7 exporting to image
#7 exporting layers done
#7 exporting manifest sha256:eaab029895282a18797f05856c3377103610efcca19188fd2c1829ee575eab5f done
#7 exporting config sha256:6681fa81f3dede64c3c62a84597b2fd40d934b9a8c216292f9809d3168b74fd7 done
#7 exporting attestation manifest sha256:9bdc6978a1b4fe5e96cc33a45b079b501dc0a7d8919a47708a411ed4dd2f4732
#7 exporting attestation manifest sha256:9bdc6978a1b4fe5e96cc33a45b079b501dc0a7d8919a47708a411ed4dd2f4732 0.1s done
#7 exporting manifest list sha256:98618bc7ab2492e86778410dce211a8351cf5f0db7570f323d4e8e713cbb8eb7
#7 exporting manifest list sha256:98618bc7ab2492e86778410dce211a8351cf5f0db7570f323d4e8e713cbb8eb7 0.1s done
#7 naming to docker.io/library/haiba00-mission1:verified
#7 naming to docker.io/library/haiba00-mission1:verified 0.1s done
#7 unpacking to docker.io/library/haiba00-mission1:verified
#7 unpacking to docker.io/library/haiba00-mission1:verified done
#7 DONE 0.5s
Exit code: 0
```

## HTTP 헤더와 본문
```text
> curl.exe --fail -i http://localhost:18082
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed

  0      0   0      0   0      0      0      0                              0
100    156 100    156   0      0  41085      0                              0
100    156 100    156   0      0  39948      0                              0
100    156 100    156   0      0  38767      0                              0
HTTP/1.1 200 OK
Server: nginx/1.31.8
Date: Sun, 15 Nov 2026 06:14:11 GMT
Content-Type: text/html
Content-Length: 156
Last-Modified: Sun, 15 Nov 2026 05:51:13 GMT
Connection: keep-alive
ETag: "6af94851-9c"
Accept-Ranges: bytes

﻿<!doctype html><html lang="ko"><meta charset="utf-8"><title>haiba-00 Mission 1</title><h1>haiba-00 개발 작업실</h1><p>Version: BEFORE</p></html>
Exit code: 0
```

## 웹 서버 운영 로그
```text
> docker logs haiba00-m1-final-web
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/11/15 05:51:16 [notice] 1#1: using the "epoll" event method
2026/11/15 05:51:16 [notice] 1#1: nginx/1.31.8
2026/11/15 05:51:16 [notice] 1#1: built by gcc 15.2.0 (Alpine 15.2.0) 
2026/11/15 05:51:16 [notice] 1#1: OS: Linux 6.18.58.1-microsoft-standard-WSL2
2026/11/15 05:51:16 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2026/11/15 05:51:16 [notice] 1#1: start worker processes
2026/11/15 05:51:16 [notice] 1#1: start worker process 30
2026/11/15 05:51:16 [notice] 1#1: start worker process 31
2026/11/15 05:51:16 [notice] 1#1: start worker process 32
2026/11/15 05:51:16 [notice] 1#1: start worker process 33
2026/11/15 05:51:16 [notice] 1#1: start worker process 34
2026/11/15 05:51:16 [notice] 1#1: start worker process 35
2026/11/15 05:51:16 [notice] 1#1: start worker process 36
2026/11/15 05:51:16 [notice] 1#1: start worker process 37
2026/11/15 05:51:16 [notice] 1#1: start worker process 38
2026/11/15 05:51:16 [notice] 1#1: start worker process 39
2026/11/15 05:51:16 [notice] 1#1: start worker process 40
2026/11/15 05:51:16 [notice] 1#1: start worker process 41
172.17.0.1 - - [15/Nov/2026:05:51:18 +0000] "GET / HTTP/1.1" 200 156 "-" "curl/8.21.0" "-"
172.17.0.1 - - [15/Nov/2026:06:13:26 +0000] "GET / HTTP/1.1" 200 156 "-" "curl/8.21.0" "-"
172.17.0.1 - - [15/Nov/2026:06:14:11 +0000] "GET / HTTP/1.1" 200 156 "-" "curl/8.21.0" "-"
Exit code: 0
```

## 리소스 사용량
```text
> docker stats --no-stream haiba00-m1-final-web
CONTAINER ID   NAME                   CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O         PIDS
5d9d2c413e85   haiba00-m1-final-web   0.00%     10.75MiB / 6.692GiB   0.16%     3.19kB / 2.49kB   5.64MB / 12.3kB   13
Exit code: 0
```

## 볼륨 생성
```text
> docker volume create haiba00-proof-20261115151413
haiba00-proof-20261115151413
Exit code: 0
```

## 컨테이너 삭제 전 실제 파일 내용
```text
> docker run --name haiba00-proof-20261115151413-writer -v haiba00-proof-20261115151413:/data ubuntu:24.04 bash -lc echo haiba00-persistent > /data/proof.txt; cat /data/proof.txt
haiba00-persistent
Exit code: 0
```

## 쓰기 컨테이너 삭제
```text
> docker rm haiba00-proof-20261115151413-writer
haiba00-proof-20261115151413-writer
Exit code: 0
```

## 새 컨테이너에서 동일 내용 유지
```text
> docker run --rm -v haiba00-proof-20261115151413:/data ubuntu:24.04 cat /data/proof.txt
haiba00-persistent
Exit code: 0
```

## 볼륨 백업: tar 파일 생성
```text
> docker run --rm -v haiba00-proof-20261115151413:/data:ro -v haiba00-proof-20261115151413-backup:/backup ubuntu:24.04 tar czf /backup/data.tgz -C /data .

Exit code: 0
```

## 볼륨 복원: 새 볼륨에 압축 해제
```text
> docker run --rm -v haiba00-proof-20261115151413-restore:/restore -v haiba00-proof-20261115151413-backup:/backup:ro ubuntu:24.04 tar xzf /backup/data.tgz -C /restore

Exit code: 0
```

## 복원된 파일 실제 내용
```text
> docker run --rm -v haiba00-proof-20261115151413-restore:/data:ro ubuntu:24.04 cat /data/proof.txt
haiba00-persistent
Exit code: 0
```

## 바인드 마운트 변경 전 응답
```text
> curl.exe --fail -i http://localhost:18083
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed

  0      0   0      0   0      0      0      0                              0
100    157 100    157   0      0   7712      0                              0
100    157 100    157   0      0   7654      0                              0
100    157 100    157   0      0   7611      0                              0
HTTP/1.1 200 OK
Server: nginx/1.31.8
Date: Sun, 15 Nov 2026 06:14:19 GMT
Content-Type: text/html
Content-Length: 157
Last-Modified: Sun, 15 Nov 2026 06:14:19 GMT
Connection: keep-alive
ETag: "6af94dbb-9d"
Accept-Ranges: bytes

<!doctype html><html lang="ko"><meta charset="utf-8"><title>haiba-00 Mission 1</title><h1>haiba-00 개발 작업실</h1><p>Version: BEFORE</p></html>
Exit code: 0
```

## 바인드 마운트 변경 후 응답
```text
> curl.exe --fail -i http://localhost:18083
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed

  0      0   0      0   0      0      0      0                              0
100    156 100    156   0      0   9910      0                              0
100    156 100    156   0      0   9852      0                              0
100    156 100    156   0      0   9744      0                              0
HTTP/1.1 200 OK
Server: nginx/1.31.8
Date: Sun, 15 Nov 2026 06:14:19 GMT
Content-Type: text/html
Content-Length: 156
Last-Modified: Sun, 15 Nov 2026 06:14:19 GMT
Connection: keep-alive
ETag: "6af94dbb-9c"
Accept-Ranges: bytes

<!doctype html><html lang="ko"><meta charset="utf-8"><title>haiba-00 Mission 1</title><h1>haiba-00 개발 작업실</h1><p>Version: AFTER</p></html>
Exit code: 0
```

## 바인드 마운트와 포트 실제 설정
```text
> docker inspect --format Ports={{json .NetworkSettings.Ports}} Mounts={{json .Mounts}} haiba00-m1-final-bind
Ports={"80/tcp":[{"HostIp":"0.0.0.0","HostPort":"18083"},{"HostIp":"::","HostPort":"18083"}]} Mounts=[{"Type":"bind","Source":"C:\\Users\\ysk00\\Documents\\Codex\\uncle-haiba-00\\mission1-submit\\web","Destination":"/usr/share/nginx/html","Mode":"","RW":false,"Propagation":"rprivate"}]
Exit code: 0
```

## Git 버전
```text
> git --version
git version 2.56.0.windows.4
Exit code: 0
```

## Git 원격 저장소
```text
> git remote -v
origin	https://haiba-00@github.com/haiba-00/mission1-workstation.git (fetch)
origin	https://haiba-00@github.com/haiba-00/mission1-workstation.git (push)
Exit code: 0
```

## Git 로컬 작성자와 브랜치
```text
> git log -1 --format=%h %an %s
d6f400e haiba-00 Format execution evidence as Markdown code blocks
Exit code: 0
```

## 원격 main 커밋 실제 조회
```text
> git ls-remote origin refs/heads/main
d6f400e70df3e2ab4365a6c5f944fe36309e8ea7	refs/heads/main
Exit code: 0
```

