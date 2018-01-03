docker run --rm -it --name rcurrie-jupyter \
    --user root \
    -e GRANT_SUDO=yes \
    -e NB_UID=`id -u $USER` \
    -e NB_GID=`getent group treehouse | cut -d: -f3` \
    -p 52820:8888 \
    -v `pwd`:/home/jovyan \
    -v /scratch/rcurrie:/scratch \
    -v /pod/pstore/groups/treehouse:/treehouse:ro \
    rcurrie-jupyter:latest start-notebook.sh \
    --NotebookApp.password='sha1:53987e611ec3:1a90d791daf75274c73f62f672ecfa935799bdee'
