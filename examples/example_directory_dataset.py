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
