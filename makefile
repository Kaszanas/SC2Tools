DATASETPREPARATOR_IMAGE := kaszanas/datasetpreparator:latest


pull_datasetpreparator: ## Pull the latest DatasetPreparator Docker image.
	docker pull $(DATASETPREPARATOR_IMAGE)

help_datasetpreparator: ## Show help for the DatasetPreparator Docker image.
	docker run -it --rm $(DATASETPREPARATOR_IMAGE) python sc2egset_pipeline.py --help

run_example:
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

shell_datasetpreparator: ## Open a shell in the DatasetPreparator Docker image.
	docker run -it --rm \
		-v "${PWD}/processing/data":/app/processing/data \
		$(DATASETPREPARATOR_IMAGE) sh

