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
