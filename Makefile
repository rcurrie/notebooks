build:
	# Build jupyter image for local use
	docker build --rm -t $(USER)-jupyter .

jupyter:
	# Run jupyter notebook on local machine - change password to your own
	docker run --rm -it --name $(USER)-jupyter \
		--user root \
		-e JUPYTER_ENABLE_LAB=1 \
		-e GRANT_SUDO=yes \
		-e NB_UID=`id -u` \
		-e NB_GID=`getent group treehouse | cut -d: -f3` \
		-p 52820:8888 \
		-p 52821:6006 \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v `echo ~`:/home/jovyan \
		-v `readlink -f ~/scratch`:/home/jovyan/scratch \
		-v `readlink -f ~/scratch/tumornormal`:/home/jovyan/tumornormal/data \
		-v /pod/pstore/groups/treehouse:/treehouse:ro \
		$(USER)-jupyter start-notebook.sh \
		--NotebookApp.password='sha1:53987e611ec3:1a90d791daf75274c73f62f672ecfa935799bdee'
