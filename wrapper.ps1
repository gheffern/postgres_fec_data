function reset-fec(){
    docker-compose build --pull | Tee-Object -FilePath  build_log.txt
    if($?) {docker system prune --volumes -f}
    if($?) { docker-compose down -t0 } 
    if($?) { docker-compose up -d }
    if($?) { docker-compose logs -f }
}