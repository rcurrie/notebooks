build:
	# Build jupyter image for local use
	docker build --rm -t $(USER)-jupyter .

jupyter:
	# Run jupyter notebook on local machine - change password to your own
	docker run --rm -it --name $(USER)-jupyter \
		--user root \
		-e GRANT_SUDO=yes \
		-e NB_UID=`id -u` \
		-e NB_GID=`id -g` \
		-p 52820:8888 \
		-p 52821:6006 \
		-v `echo ~`:/home/jovyan \
		-v `readlink -f ~/data`:/home/jovyan/data \
		-v `readlink -f ~/scratch`:/home/jovyan/scratch \
		$(USER)-jupyter start-notebook.sh \
		--NotebookApp.password='sha1:53987e611ec3:1a90d791daf75274c73f62f672ecfa935799bdee'
