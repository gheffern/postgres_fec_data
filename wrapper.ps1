function reset-fec(){
    docker-compose build
    if($?) { docker-compose down -t0 }
    if($?) { docker-compose up -d }
    if($?) { docker-compose logs -f }
}