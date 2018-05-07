DOCKER_DB_NAME="$(docker-compose ps -q db)"
DB_HOSTNAME=myroscope_development
DB_USER=postgres
LOCAL_DUMP_PATH="dumps/latest.dump"

docker-compose up -d db
sleep 5
docker exec -i "${DOCKER_DB_NAME}" pg_restore --verbose --clean --no-acl --no-owner -U "${DB_USER}" -d "${DB_HOSTNAME}" < "${LOCAL_DUMP_PATH}"
docker-compose stop db


# pg_restore --verbose --clean --no-acl --no-owner -h localhost -U myuser -d mydb dumps/latest.dump
