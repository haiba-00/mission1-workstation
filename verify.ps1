$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
New-Item -ItemType Directory -Force logs | Out-Null
Start-Transcript -Path logs/verification.txt -Force
function Run([string]$Command) { Write-Host "`n> $Command"; Invoke-Expression $Command; if ($LASTEXITCODE -ne 0) { Write-Host "Exit: $LASTEXITCODE" } }
Run 'git --version'
Run 'docker --version'
Run 'docker info'
Run 'git config --local --list'
(Get-Content web/index.html -Raw -Encoding utf8).Replace('AFTER','BEFORE') | Set-Content web/index.html -Encoding utf8
Run 'docker run --rm hello-world'
Run 'docker run --name haiba00-m1-final-linux -d ubuntu:24.04 sleep infinity'
Run 'docker exec haiba00-m1-final-linux bash -lc ''pwd; ls -la; mkdir -p /practice/demo; cd /practice; touch empty.txt; echo hello > original.txt; cp original.txt copy.txt; mv copy.txt renamed.txt; cat renamed.txt; rm renamed.txt; ls -la; ls -ld empty.txt demo; chmod 600 empty.txt; chmod 700 demo; ls -ld empty.txt demo'''
Run 'docker exec haiba00-m1-final-linux echo exec-returned-container-still-running'
Run 'docker ps'
Run 'docker build -t haiba00-mission1:1.0 .'
Run 'docker run -d --name haiba00-m1-final-web -p 18082:80 haiba00-mission1:1.0'
Start-Sleep -Seconds 2
Run 'curl.exe --fail http://localhost:18082'
$mount = "type=bind,source=$PSScriptRoot\web,target=/usr/share/nginx/html,readonly"
Write-Host "`n> docker run -d --name haiba00-m1-final-bind -p 18083:80 --mount $mount haiba00-mission1:1.0"
docker run -d --name haiba00-m1-final-bind -p 18083:80 --mount $mount haiba00-mission1:1.0
Start-Sleep -Seconds 2
Run 'curl.exe --fail http://localhost:18083'
(Get-Content web/index.html -Raw -Encoding utf8).Replace('BEFORE','AFTER') | Set-Content web/index.html -Encoding utf8
Run 'curl.exe --fail http://localhost:18083'
Run 'docker volume create haiba00-m1-final-data'
Run 'docker run --name haiba00-m1-final-vol-before -v haiba00-m1-final-data:/data ubuntu:24.04 bash -lc ''echo haiba00-persistent > /data/proof.txt; cat /data/proof.txt'''
Run 'docker rm haiba00-m1-final-vol-before'
Run 'docker run --rm -v haiba00-m1-final-data:/data ubuntu:24.04 cat /data/proof.txt'
Run 'docker images'
Run 'docker logs haiba00-m1-final-web'
Run 'docker stats --no-stream haiba00-m1-final-web haiba00-m1-final-bind'
Run 'docker stop haiba00-m1-final-linux'
Run 'docker ps -a'
Stop-Transcript


