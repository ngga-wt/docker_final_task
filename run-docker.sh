#! /usr/bin/env bash

maxCountEnv=$([[ -n "$1" && "$1" =~ ^-?[0-9]+$ ]] && echo "$1" || echo 1)
containerName="AlpCon"

# Build docker image.
docker build -t alpine_img .

# Checks if AlpCon is running
alpContainer="$(docker ps -a | sed -rn "s/.*($containerName)$/\1/p")"
if [ -z "$alpContainer" ]; then

  # Run image to create container named AlpCon.
  docker run -d --rm --name $containerName -e maxCountEnv="$maxCountEnv" -v "$PWD/public":/app/public alpine_img
else echo "Container $containerName is allready running" && exit 1; fi

# Waits for 10 seconds.
echo 'Sleeping 10 seconds...'
sleep 10
echo 'Sleeping 10 seconds...finished.'

# get container proccess
alpProccess="$(docker exec AlpCon ps aux 2>/dev/null)"
echo -e "\nalpine container proccess:\n$alpProccess\n"

# if the python file is still running
pid="$(echo "$alpProccess" | grep 'entrypoint.py' | sed -rn 's/^\s*([2-9]).*/\1/p')"
if [ -n "$pid" ]; then

  # kill it and print test failed
  docker exec "$containerName" kill -9 "$pid" && echo -e "\nTest failed, running python file with proccess id: $pid was killed!"
else echo "python file is not running!"; fi

# stop container if still running
alpContainer="$(docker container ls | sed -rn "s/.*($containerName)$/\1/p")"
if [ -n "$alpContainer" ]; then
  docker stop "$alpContainer" &>/dev/null && echo "$alpContainer container stoped!"
fi

echo "Task have been finished successfuly!"
