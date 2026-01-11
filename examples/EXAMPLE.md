# End to End Example for SC2Tools Suite

The following example demonstrates how to use the complete SC2Tools suite to process StarCraft II replay files from start to finish. **SC2InfoExtractorGo** is the primary processing tool, and `SC2_Datasets` is used for dataset handling and analysis.

## Prerequisites

- Docker (recommended)
- StarCraft II replay files (`.SC2Replay`), you can download them from [SC2ReSet HuggingFace](https://huggingface.co/datasets/Kaszanas/SC2ReSet) or [SC2ReSet Zenodo](https://doi.org/10.5281/zenodo.5575796)

## Quick Start with Docker (Recommended)

The fastest way to process replays is using our pre-built Docker image:

```bash
# 1. Create necessary directories
mkdir -p ./processing/sc2infoextractorgo_input
mkdir -p ./processing/sc2infoextractorgo_output
mkdir -p ./processing/sc2infoextractorgo_output/logs
mkdir -p ./processing/sc2infoextractorgo_output/maps

# 2. Place your .SC2Replay files in ./processing/sc2infoextractorgo_input

# 3. Process replays with SC2InfoExtractorGo
docker run --rm \
  -v ${PWD}/processing/sc2infoextractorgo_input:/app/processing/sc2infoextractorgo_input \
  -v ${PWD}/processing/sc2infoextractorgo_output:/app/processing/sc2infoextractorgo_output \
  kaszanas/sc2infoextractorgo:latest \
  -input /app/processing/sc2infoextractorgo_input \
  -output /app/processing/sc2infoextractorgo_output \
  -log_dir /app/processing/sc2infoextractorgo_output/logs \
  -maps_directory /app/processing/sc2infoextractorgo_output/maps \
  -log_level 5
```

After the processing is complete, you will find the processed JSON files in the `./processing/sc2infoextractorgo_output` directory under `package_0.zip`. Unpack this zip file to access individual JSON files for each replay and use the API as illustrated in [Using the Dataset API](#using-the-dataset-api).

**What this does:**
- Extracts game data from replay files
- Downloads required maps from Blizzard servers
- Performs data cleanup and validation
- Outputs structured JSON files


## Understanding the Output

### JSON Structure

Each processed replay generates a JSON file with this structure:

```json

```

### Expected Files

After processing, you'll find:

```
processing/
├── replays/
│   ├── sc2infoextractorgo_input/  # Original .SC2Replay files that you have placed
│   └── sc2infoextractorgo_output/ # Output directory
│       ├── package_0.zip          # Processed JSON files (compressed)
|       |-- logs/                  # Log files from processing
|       |-- maps/                  # Downloaded map files
│       └── ...                    # Other output files
```

## Using the Dataset API

Examples of using the `SC2_Datasets` library to read and analyze the processed JSON files are provided in the [SC2_Datasets README](SC2_Datasets/README.md) and its supporting documentation.

Once you have processed JSON files:

1. You can load the processed dataset using one of the PyTorch dataset classes provided in the `SC2_Datasets` library. For example, to load the data you just processed, you can use the `SC2DirectoryDataset` as shown in [example_directory_dataset.py](examples/example_directory_dataset.py):

```python
from pathlib import Path

from sc2_datasets.torch.datasets.sc2_dataset_directory import SC2DatasetDirectory

if __name__ == "__main__":
    unpack_dir = Path("./processing/sc2infoextractorgo_output/package_0").resolve()

    directory_dataset = SC2DatasetDirectory(directory=unpack_dir)

    for idx in range(len(directory_dataset)):
        replay_data = directory_dataset[idx]
        print(
            f"Replay metadata: {replay_data.metadata.gameVersion=} {replay_data.metadata.mapName=},"
        )

```

2. If you wish to work with the JSON files directly, you can use the SC2_Datasets Python library to load raw JSON files. This allows to work with the data programmatically [example_load_raw.py](examples/example_load_raw.py):

```
# Create a virtual environment
python -m venv .venv

# Activate the virtual environment
# On Windows
.venv/Scripts/activate
# On Unix or MacOS
source .venv/bin/activate

# Install the library
pip install sc2-datasets
```

```python
from pathlib import Path

from sc2_datasets.replay_data.sc2_replay_data import SC2ReplayData

if __name__ == "__main__":
    unpack_dir = Path("./processing/sc2infoextractorgo_output/package_0").resolve()

    # Get all JSON files in the unpacked directory:
    json_files = list(unpack_dir.rglob("*.json"))

    # Iterate through games:
    for json_file in json_files:
        replay_data = SC2ReplayData.from_file(json_file)
        print(
            f"Replay metadata: {replay_data.metadata.gameVersion=} {replay_data.metadata.mapName=},"
        )
```


## Troubleshooting

### Common Issues

1. **No output files generated:**
   - Check logs for error messages.
   - Verify input directory contains .SC2Replay files.
   - Ensure sufficient disk space.

2. **Map download failures:**
   - Check internet connection.
   - Verify Blizzard servers are accessible.
   - Use `-skip_map_download` if you have maps downloaded already.

## Next Steps

- Explore the [SC2_Datasets documentation](SC2_Datasets/README.md) for advanced data analysis.
- Check the [DatasetPreparator tools](DatasetPreparator/README.md) for large-scale dataset preparation.
- Review the [SC2AnonServerPy documentation](SC2AnonServerPy/README.md) for anonymization options.

## Support

For issues and questions:
- Check individual tool README files.
- Review GitHub issues for each repository.
- Contact maintainers through GitHub discussions.