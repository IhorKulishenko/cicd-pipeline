container_name=$1
image_name=$2

image_id=$(docker image ls --filter "reference=$image_name"  --format='{{json .ID}}')
if [[ -z "$image_id" ]]; then
    echo "can't find image $image_name"
    exit 1
fi

container_id=$(docker ps --filter "name=$container_name"  --format='{{json .ID}}')

if [[ -n "$container_id" ]]; then
    docker container stop $container_id
    docker container rm $container_id
fi

docker run --name $container_name -d -p 3000:3000 $image_name

