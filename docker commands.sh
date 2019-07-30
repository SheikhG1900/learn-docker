### tomcat ###
docker run -v E:\officeWork\docker-tomcat-deployment:/usr/local/tomcat/webapps --name tomcat  -it --rm -p 8888:8080 tomcat:8.0

########  setup guacamole start ######

# setup mysql for guacamole with root password 'root'
docker run --name guac-mysql -e MYSQL_ROOT_PASSWORD='root' -d mysql
mysql> CREATE USER 'sh' IDENTIFIED BY 'aw';
mysql> GRANT SELECT,INSERT,UPDATE,DELETE ON guacamole_db.* TO 'sh';


# setup postgres for guacamole with root password 'root'
docker run --name guac-postgres -p 5432:5432 -e POSTGRES_PASSWORD=root -d postgres


# generate mysql and postgres script
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > initdb.mysql.sql
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > initdb.postgres.sql

# run guacamole server. (guacd)
docker run --name guacd -d -p 4822:4822 guacamole/guacd

# run guacamole client web application (mysql) 
docker run --name guacamole --link guacd:guacd --link guac-mysql:mysql -e MYSQL_DATABASE=guacamole_db  -e MYSQL_USER=usr  -e MYSQL_PASSWORD=aw -p 8080:8080 -d guacamole/guacamole

# run guacamole client web application (postgres) 
docker run --name guacamole --link guacd:guacd --link guac-postgres:postgres -e POSTGRES_DATABASE=guacamole_db  -e POSTGRES_USER=postgres  -e POSTGRES_PASSWORD=root --rm -p 8080:8080 guacamole/guacamole

########  setup guacamole end ######






#### run container
docker run -t -i --name mycotainer ubuntu  # interactive with name
docker run -t -i ubuntu # interactive 
docker run -p 4000:80 friendlyhello:snapshot # with port mapping
docker run -d -p 4000:80 friendlyhello:snapshot # with port mapping de-attached
docker run -e GUACD_LOG_LEVEL=debug -d guacamole/guacd  # -e is env variable.
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > initdb.sql # run container for short. --rm means to delete container after it is done.


### mount storage ####
docker volume create temp  # create volume with name, temp
docker volume inspect temp # inpect volume
docker run --mount source=temp,target=/path/of/container some-image # mount valume to a contanier inside path 
docker volume rm virtualenv # remove volume
docker run -v /host/path:/container/path -p 8069:8069 --name odoo --link db:db -t odoo # run container with mounted valume host/path:container/path
# use running docker terminal
docker exec -it some-mysql bash  # run mysql in terminal

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


#### copy file to container  ####
docker cp  ./auth.jsp guacamole:/usr/local/tomcat/webapps/guacamole/auth.jsp

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