To build core docker container: `docker build [path_to_dockerfile]`
To show docker containers available on machine: `docker images`

First run XQuartz -> preferences, security -> allow connections from network clients, then run from a terminal:
~~~~
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip
docker run -ti -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$ip:0 --rm -v ~/work/scratch/nipype_tutorial/:/output miykael/nipype_course ipython
~~~~
