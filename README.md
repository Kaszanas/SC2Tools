# SC2Tools: StarCraft II Toolset and Dataset API

This repository contains a comprehensive toolset for working with StarCraft II replay files and datasets. The tools span multiple programming languages and are included as git submodules for easy management and development.

## Quickstart

### What Each Tool Does

- **SC2InfoExtractorGo**: Extracts detailed game data from .SC2Replay files into JSON format, for anonymization see SC2AnonServerPy.
- **DatasetPreparator**: Prepares and organizes large replay datasets for processing.
- **SC2AnonServerPy**: Provides anonymization gRPC service for player data and chat messages, works with SC2InfoExtractorGo.
- **SC2_Datasets**: Python library for loading and working with processed SC2 datasets.

For a comprehensive information on each tool, please refer to their individual `README.md` files.

### Prerequisites

- Docker (recommended) or:
  - Go 1.19+ for SC2InfoExtractorGo
  - Python 3.10+ for Python-based tools
  - Poetry for Python dependency management
  - Git for submodule management

> [!NOTE]
> DatasetPreparator software container image contains the SC2InfoExtractorGo by default. Please refer to [DatasetPreparator README](DatasetPreparator/README.md) for more details.


### Docker Usage (Recommended)

The easiest way to get started is using our pre-built Docker images:

0. Collect your .SC2Replay files into a replaypack, for example: `replaypack_1/*.SC2Replay`. If you do not have any replays, and you wish to run the following example, you can download some replaypacks from [SC2ReSet HuggingFace](https://huggingface.co/datasets/Kaszanas/SC2ReSet) or [SC2ReSet Zenodo](https://doi.org/10.5281/zenodo.5575796).
1. **Pull and run DatasetPreparator (full processing pipeline):**
   1. Run the following to see available options:
    ```bash
    docker pull kaszanas/datasetpreparator:latest

    docker run -it --rm \
    -v "${PWD}/processing":/app/processing \
    kaszanas/datasetpreparator:latest \
    python sc2egset_pipeline.py --help
    ```
    2. Place your replaypack directories in `./processing/data/replays` directory. For example:
        ```
        ./processing/data/replays/replaypack_1/*.SC2Replay
        ./processing/data/replays/replaypack_2/*.SC2Replay
        ``` 
       1. To run the full processing pipeline (as in SC2ReSet and SC2EGSet datasets), execute:
        ```bash
        docker run -it --rm \
        -v "${PWD}/processing/data":/app/processing/data \
        kaszanas/datasetpreparator:latest \
        python sc2egset_pipeline.py \
        --input_path processing/data/replays \
        --output_path processing/data/output \
        --maps_path processing/maps \
        --n_processes 4 \
        --force_overwrite True
        ```

To verify if everything worked correctly, check the generated logs and the `processing/data/output` directory for processed files. The `directory_flattener` directory should contain the structure as in the input directory, but with a single level directories containing raw `.SC2Replay` files and a mapping from the old directory structure to the filenames `processed_mapping.json`. Moreover, the `sc2egset_replaypack_processor` directory should contain the output from SC2InfoExtractorGo ran with the same arguments as the SC2EGSet dataset processing. Finally `SC2ReSet` and `SC2EGSet` directory should contain the raw replay files as organized in the respective datasets.


### Installation (Without Docker)

1. **Clone the repository with submodules:**
   ```bash
   git clone --recurse-submodules https://github.com/Kaszanas/SC2Tools.git
   cd SC2Tools
   ```

2. **Initialize and update submodules:**
   ```bash
   git submodule update --init --recursive
   ```

> [!NOTE]
> At this point, you should be able to use the tools directly on your system if you have the necessary dependencies installed.
> Please refer to each tool's `README.md` for specific installation and usage instructions.

## Individual Tool Documentation

Each tool has its own comprehensive documentation:

- [SC2InfoExtractorGo Documentation](SC2InfoExtractorGo/README.md)
- [DatasetPreparator Documentation](DatasetPreparator/README.md)
- [SC2AnonServerPy Documentation](SC2AnonServerPy/README.md)
- [SC2_Datasets Documentation](SC2_Datasets/README.md)

## Contributing

Contributions are welcome`! Please see the individual tool repositories for contribution guidelines and development setup instructions.

## Licenses

> [!NOTE]
> Each of the repositories (submodules) contains a separate license.
> Please refer to the respective submodule for its specific license terms.

