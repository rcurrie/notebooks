build:
	# Build jupyter image for local use
	docker build --rm -t $(USER)-jupyter .

shell:
	docker exec -it $(USER)-jupyter /bin/bash

run:
	# Run a notebook on the command line with no timeout
	jupyter nbconvert --ExecutePreprocessor.timeout=None --to notebook \
		--execute $(NOTEBOOK).ipynb  --output $(NOTEBOOK).ipynb

jupyter:
	# Run jupyter notebook on local machine - change password to your own
	# Set user and group to myself and treehouse on the host OS
	docker run --rm -it --name $(USER)-jupyter \
		--user=root:root \
		-e NB_GID=`getent group treehouse | cut -d: -f3` \
		-e NB_UID=`id -u` \
		-e DEBUG=True \
		-p 52820:8888 \
		-p 52821:6006 \
		-v `echo ~`/notebooks:/home/jovyan/notebooks \
		-v `echo ~`/deepmarker:/home/jovyan/deepmarker \
		-v `readlink -f ~/data`:/home/jovyan/data \
		$(USER)-jupyter:latest start-notebook.sh \
		--NotebookApp.password='sha1:53987e611ec3:1a90d791daf75274c73f62f672ecfa935799bdee'

create_venv:
	virtualenv -p python3 venv

activate_venv:
	source venv/bin/activate
