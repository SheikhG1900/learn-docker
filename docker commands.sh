#### run container
docker run -t -i --name mycotainer ubuntu  # interactive with name
docker run -t -i ubuntu # interactive 
docker run -p 4000:80 friendlyhello:snapshot # with port mapping
docker run -d -p 4000:80 friendlyhello:snapshot # with port mapping de-attached


#### see containter
docker ps
docker ps -a # all
docker ps -a -q # all container ids. 


#### remove container
docker rm <containerName>


#### stop all containers (https://stackoverflow.com/questions/49951819/unable-to-run-friendlyhello-tutorial-in-docker/54704320#54704320)
docker stop $(docker ps -a -q) # for linux

# for windows
docker ps -a -q # 1- get list of all containder ids.
docker stop 0ab2490f8d9c 9dff282e510e 99f64a57b68f # 2- stop all by providing list


#### docker machine ip
docker-machine ip


#### see images
docker images


#### build image
docker build --tag=friendlyhello .
docker build -t friendlyhello . # short form
docker build -t friendlyhello:v0.0.1 . # with version 


#### publish image
docker tag friendlyhello sheikhg1900/aw-first-repo:sample-01  # tag the image.
docker push sheikhg1900/aw-first-repo:sample-01  #push tagged image


#### see deployments/services.
docker service ls


#### see list of containers/tasks for a service/deployment 
docker service ps myApp_web   # getstartedlab_web is service name

#### manage application/stack
docker stack deploy -c docker-compose.yml myApp  # deploy application   -c > --compose-file 
docker stack ps myApp  # to see all tasks of stack
docker stack rm myApp  # take stack down




#####################   official cheet sheet   ############################
## List Docker CLI commands
docker
docker container --help

## Display Docker version and info
docker --version
docker version
docker info

## Execute Docker image
docker run hello-world

## List Docker images
docker image ls

## List Docker containers (running, all, all in quiet mode)
docker container ls
docker container ls --all
docker container ls -aq


docker build -t friendlyhello .  # Create image using this directory's Dockerfile
docker run -p 4000:80 friendlyhello  # Run "friendlyname" mapping port 4000 to 80
docker run -d -p 4000:80 friendlyhello         # Same thing, but in detached mode
docker container ls                                # List all running containers
docker container ls -a             # List all containers, even those not running
docker container stop <hash>           # Gracefully stop the specified container
docker container kill <hash>         # Force shutdown of the specified container
docker container rm <hash>        # Remove specified container from this machine
docker container rm $(docker container ls -a -q)         # Remove all containers
docker image ls -a                             # List all images on this machine
docker image rm <image id>            # Remove specified image from this machine
docker image rm $(docker image ls -a -q)   # Remove all images from this machine
docker login             # Log in this CLI session using your Docker credentials
docker tag <image> username/repository:tag  # Tag <image> for upload to registry
docker push username/repository:tag            # Upload tagged image to registry
docker run username/repository:tag                   # Run image from a registry


docker stack ls                                            # List stacks or apps
docker stack deploy -c <composefile> <appname>  # Run the specified Compose file
docker service ls                 # List running services associated with an app
docker service ps <service>                  # List tasks associated with an app
docker inspect <task or container>                   # Inspect task or container
docker container ls -q                                      # List container IDs
docker stack rm <appname>                             # Tear down an application
docker swarm leave --force      # Take down a single node swarm from the manager