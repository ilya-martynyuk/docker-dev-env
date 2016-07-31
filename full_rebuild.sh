docker-compose stop $1
echo 'y' | docker-compose rm $1
docker-compose build $1
docker-compose up -d $1