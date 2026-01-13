DATASETPREPARATOR_IMAGE := kaszanas/datasetpreparator:latest


pull_datasetpreparator: ## Pull the latest DatasetPreparator Docker image.
	docker pull $(DATASETPREPARATOR_IMAGE)

help_datasetpreparator: ## Show help for the DatasetPreparator Docker image.
	docker run -it --rm $(DATASETPREPARATOR_IMAGE) python sc2egset_pipeline.py --help

run_datasetpreparator_example:
	docker run -it --rm \
		-v "${PWD}/processing/data":/app/processing/data \
		$(DATASETPREPARATOR_IMAGE) \
		python sc2egset_pipeline.py \
		--input_path ./processing/data/replays \
		--output_path ./processing/data/output \
		--maps_path ./processing/maps \
		--n_processes 4 \
		--force_overwrite True \
		--log INFO

run_sc2infoextractorgo_example:
	docker run -it --rm \
		-v ${PWD}/processing:/app/processing \
		kaszanas/sc2infoextractorgo:latest \
		-input ./processing/sc2infoextractorgo_input \
		-output ./processing/sc2infoextractorgo_output \
		-log_dir ./processing/sc2infoextractorgo_output/logs \
		-maps_directory /app/processing/sc2infoextractorgo_output/maps \
		-log_level 4


shell_datasetpreparator: ## Open a shell in the DatasetPreparator Docker image.
	docker run -it --rm \
		-v "${PWD}/processing/data":/app/processing/data \
		$(DATASETPREPARATOR_IMAGE) sh

