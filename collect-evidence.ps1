$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
$script:lines = [System.Collections.Generic.List[string]]::new()
function Capture([string]$Title, [string[]]$CommandArgs) {
    $script:lines.Add("## $Title")
    $script:lines.Add('```text')
    $script:lines.Add('> ' + ($CommandArgs -join ' '))
    $exe = $CommandArgs[0]
    $rest = $CommandArgs[1..($CommandArgs.Length-1)]
    $result = & $exe @rest 2>&1 | Out-String
    $code = $LASTEXITCODE
    $result = $result.Replace($PSScriptRoot,'<REPOSITORY>').Replace('C:\Users\ysk00','<USER_HOME>')
    $script:lines.Add($result.TrimEnd())
    $script:lines.Add("Exit code: $code")
    $script:lines.Add('```')
    $script:lines.Add('')
    if ($code -ne 0) { throw "Failed: $Title ($code)" }
}
Capture 'Docker 버전' @('docker','--version')
Capture 'Docker 데몬 실제 출력' @('docker','info','--format','ServerVersion={{.ServerVersion}}; OSType={{.OSType}}; Driver={{.Driver}}; Containers={{.Containers}}; Images={{.Images}}')
Capture 'hello-world 전체 실행 출력' @('docker','run','--rm','hello-world')
Capture 'Ubuntu 터미널 조작 및 권한 전후' @('docker','run','--rm','ubuntu:24.04','bash','-lc','mkdir -p /practice/demo; cd /practice; pwd; ls -la; touch empty.txt; echo hello > original.txt; cp original.txt copy.txt; mv copy.txt renamed.txt; cat renamed.txt; rm renamed.txt; chmod 644 empty.txt; chmod 755 demo; echo BEFORE; ls -ld empty.txt demo; chmod 600 empty.txt; chmod 700 demo; echo AFTER; ls -ld empty.txt demo')
Capture 'Docker 이미지 실제 목록' @('docker','images','haiba00-mission1')
Capture 'Docker 컨테이너 실제 목록' @('docker','ps','-a','--filter','name=haiba00-')
Capture 'Dockerfile 빌드 전체 로그' @('docker','build','--progress=plain','-t','haiba00-mission1:verified','.')
Capture 'HTTP 헤더와 본문' @('curl.exe','--fail','-i','http://localhost:18082')
Capture '웹 서버 운영 로그' @('docker','logs','haiba00-m1-final-web')
Capture '리소스 사용량' @('docker','stats','--no-stream','haiba00-m1-final-web')
$volume = 'haiba00-proof-' + (Get-Date -Format 'yyyyMMddHHmmss')
$writer = $volume + '-writer'
Capture '볼륨 생성' @('docker','volume','create',$volume)
Capture '컨테이너 삭제 전 실제 파일 내용' @('docker','run','--name',$writer,'-v',"${volume}:/data",'ubuntu:24.04','bash','-lc','echo haiba00-persistent > /data/proof.txt; cat /data/proof.txt')
Capture '쓰기 컨테이너 삭제' @('docker','rm',$writer)
Capture '새 컨테이너에서 동일 내용 유지' @('docker','run','--rm','-v',"${volume}:/data",'ubuntu:24.04','cat','/data/proof.txt')
$backup = $volume + '-backup'
$restore = $volume + '-restore'
Capture '볼륨 백업: tar 파일 생성' @('docker','run','--rm','-v',"${volume}:/data:ro",'-v',"${backup}:/backup",'ubuntu:24.04','tar','czf','/backup/data.tgz','-C','/data','.')
Capture '볼륨 복원: 새 볼륨에 압축 해제' @('docker','run','--rm','-v',"${restore}:/restore",'-v',"${backup}:/backup:ro",'ubuntu:24.04','tar','xzf','/backup/data.tgz','-C','/restore')
Capture '복원된 파일 실제 내용' @('docker','run','--rm','-v',"${restore}:/data:ro",'ubuntu:24.04','cat','/data/proof.txt')
$original = Get-Content web/index.html -Raw -Encoding utf8
try {
    $original.Replace('AFTER','BEFORE') | Set-Content web/index.html -Encoding utf8
    Capture '바인드 마운트 변경 전 응답' @('curl.exe','--fail','-i','http://localhost:18083')
    $original.Replace('BEFORE','AFTER') | Set-Content web/index.html -Encoding utf8
    Capture '바인드 마운트 변경 후 응답' @('curl.exe','--fail','-i','http://localhost:18083')
} finally { Set-Content web/index.html $original -Encoding utf8 }
Capture '바인드 마운트와 포트 실제 설정' @('docker','inspect','--format','Ports={{json .NetworkSettings.Ports}} Mounts={{json .Mounts}}','haiba00-m1-final-bind')
Capture 'Git 버전' @('git','--version')
Capture 'Git 원격 저장소' @('git','remote','-v')
Capture 'Git 로컬 작성자와 브랜치' @('git','log','-1','--format=%h %an %s')
Capture '원격 main 커밋 실제 조회' @('git','ls-remote','origin','refs/heads/main')
$script:lines | Set-Content logs/actual-output.md -Encoding utf8
Write-Host 'Saved logs/actual-output.md with captured native stdout/stderr.'
