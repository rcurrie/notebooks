build:
	# Build jupyter image for local use
	docker build --rm -t $(USER)-jupyter .

exec:
	docker -it 

run:
	# Run a notebook on the command line with no timeout
	jupyter nbconvert --ExecutePreprocessor.timeout=None --to notebook --execute ingest.ipynb  --output ingest.2.ipynb

jupyter:
	# Run jupyter notebook on local machine - change password to your own
	docker run --rm -it --name $(USER)-jupyter \
		--user root \
		-e GRANT_SUDO=yes \
		-e NB_GID=`getent group treehouse | cut -d: -f3` \
		-e NB_UID=`id -u` \
		-p 52820:8888 \
		-p 52821:6006 \
		-v `echo ~`:/home/jovyan \
		-v /scratch/rcurrie/data:/home/jovyan/data \
		-v /scratch/rcurrie/data:/home/jovyan/tumornormal/data \
		-v /scratch/rcurrie/data:/home/jovyan/deepmarker/data \
		-v /pod/pstore/groups/treehouse:/treehouse:ro \
		$(USER)-jupyter:latest start-notebook.sh \
		--NotebookApp.password='sha1:53987e611ec3:1a90d791daf75274c73f62f672ecfa935799bdee'

		# -e JUPYTER_ENABLE_LAB=1 \
		# -v `readlink -f ~/scratch`:/home/jovyan/scratch \
		# -v `readlink -f ~/scratch/tumornormal`:/home/jovyan/tumornormal/data \
