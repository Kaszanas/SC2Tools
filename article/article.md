---
authors:
  - name: Andrzej Białecki
    affiliation: '1'

  - name: Piotr Białecki
    affiliation: '2'

  - name: Piotr Sowiński
    affiliation: '1, 4'

  - name: Mateusz Budziak
    affiliation: '2'

  - name: Jan Gajewski
    affiliation: '3'


affiliations:
  - index: 1
    name: Warsaw University of Technology, Poland
  - index: 2
    name: Independent Researcher
  - index: 3
    name: Józef Piłsudski University of Physical Education in Warsaw, Poland
  - index: 4
    name: NeverBlink, Poland
---



# Introduction and Background

Computer games as fully controlled simulated environments were used in major scientific works that showcased the application of Reinforcement Learning (RL). As such, computer games can be viewed as one of the many components of major breakthroughs and advancements in RL applications [@Szita2012RLGames,@Samsuden2019RLGames,@LanctotEtAl2019OpenSpiel,@Shao2019RLSurvey,@Jayaramireddy2023RLSurvey,@Vinyals2019,@Wurman2022].

Despite heightened interest in research on gaming and esports, there are limited high-level libraries and tools made for rapid experimentation in some game titles. Researchers from various research disciplines have shown their interest in exploring gaming and esports, including: (1) psychology [@Campbell2018], (2) computer science [@Rashid2020,@Yuan2021ActorCritic], (3) education [@Jensen2024,@Jenny2021], (4) medical sciences [@Krarup2020109344], and others [@Holden2017Law,Nagorsky2020].
The ability to tie these topics with the in-game data cannot be overstated.

When such software is available, it is often hard to use for less technically proficient researchers. Data parsing libraries are prevalent in computer games, such as Counter-Strike [@AWPYXeno2020,ClarityGitHub], Rocket&nbsp;League [@URLBoxcars2016], Dota&nbsp;2 [@OpenDotaGitHub,@ClarityGitHub], and finally in StarCraft&nbsp;2 [@URLBlizzardS2ClientProto,@URLS2Prot2016,@GitHubSC2Reader].

Esports can be treated as a subset of gaming with additional requirements for players, such as tournament presence, organized play, training, and professionalization [@Formosa2022]. The study of esports is multidisciplinary in nature [@Brock2023Interdisciplinary,@Pizzo2022Interdisciplinary]. Due to the growing academic interest in the area of gaming and esports [@Yamanaka2021Review,@Reitman2020Review,@Tang2023Review,@Bialecki2024Review], it is key to provide tools for researchers capable of simplifying the process of acquiring large datasets efficiently, not only for authors interested in the area of computer science [@Ferenczi2024sc2_serizlizer,@SmerdovLoLDataset2021].

In case of our implementation, we focus on solving problems within the StarCraft&nbsp;2 (SC2) infrastructure ecosystem. StarCraft&nbsp;2 is a real-time strategy game developed by Blizzard Entertainment. The game is known as one of the most prominent real-time strategy (RTS) esports titles [@Tyreal2020,Dal2020]. It is also characterized by its fast-paced gameplay and a high skill ceiling [@Migliore2021]. These attributes make for a great environment for testing various AI agents [@Ma2024LLMStarCraft2,@Vinyals2019,@Samvelyan2019SMAC,@Pearce2022CSGO]. Moreover, research in StarCraft&nbsp;2 is not limited to AI agents -- there are efforts to analyze the game from various perspectives and provide insights that can assist players in their gameplay [@URLSC2AICoach2022LLM,@URLSc2replaystats].

Our software collection is an open-source implementation of data extraction, and data interfacing tools for StarCraft&nbsp;2. We solve the problem of ease of access to the data encoded in files with ".SC2Replay" extension by using an open-source file extractor for proprietary MoPAQ (MPQ) file format. From this point on, we will refer to the MPQ files with the ".SC2Replay" extension as SC2Replay files.

So far, our software was leveraged in preparation of major datasets: "SC2ReSet" [@Bialecki2022ReSetZenodo] and "SC2EGSet" [@Bialecki2023EGSetZenodo] with an accompanying peer-reviewed and published Data Descriptor article [@Bialecki2023SC2EGSet]. The output of our software was used in varying contexts indirectly. authors cited our work, some of them following the general flow of our exploration [@Kim2024]. Others put emphasis on statistical calculation within esports landscape [@Dupuy2024]. Finally authors describe our work in surveys of related work when working in another games [@Johar2024].

Our solution uses the official StarCraft 2 replay file format specification provided via Blizzard Entertainment GitHub repository [@URLBlizzards2protocol2013]. Specifically, in "SC2InfoExtractorGo", we extend the community-built Golang implementation of the parser [@URLS2Prot2016,@URLMPQ2017]. The output of our software pipeline is a fully prepared dataset, ready for use with our extension of PyTorch [@PyTorch2019] and PyTorch Lightning interfaces [@PyTorch_Lightning_2019]. Our goal was to lower the technical knowledge required to obtain data from in-game replays.

# Software Description

Our software consists of multiple modules that the user can match to their specific needs. To easily extend our toolset, the main repository of "SC2Tools" contains multiple git submodules. Each submodule is a separate repository with the logic required to perform a specific tasks on the SC2Replay files. The motivation for this structure is twofold. Firstly, it makes evolving the toolset easier, as modules can be easily replaced, or new ones added. Secondly, users have the option of using only a portion of the pipeline. The full list of current submodules is as follows: (1) "SC2InfoExtractorGo" [@Bialecki_2021_SC2InfoExtractorGo], (2) "DatasetPreparator" [@Bialecki_2022_SC2DatasetPreparator], (3) "SC2AnonServerPy" [@Bialecki_2021_SC2AnonServerPy]. (4) "SC2_Datasets" [@bialecki_2022_sc2datasets].

In case of developing future tools, deprecating or improving the existing implementations, updates will be made to the common open-source repository. In their current state, all of the tools can be either used independently or combined in a data processing pipeline. The pipeline can interoperate with other software tools, as long as they use standard SC2Replay files for inputs to the "SC2InfoExtractorGo". Finally, loading the data for experiments is supported as long as the output is saved in Java Script Object Notation (JSON) files with ".json" extension, and conforms to a pre-defined schema defined by the "SC2_Datasets" parser. From now on, we will refer to such files as JSON files. In the current version extending the software with additional tools is possible, and we encourage the community to contribute to the project for future releases.

## Software Architecture

Tools and scripts in our repository have singular responsibilities. Each of our submodules fulfills a specific part of the data processing needs within the pipeline. The full pipeline in a simplified pictorial form is showcased in \autoref{fig:DatasetPipeline}. Note the distinctive steps of data pre-processing are introduced in#  "DatasetPreparator" for the Python utility scripts. Further, data processing Golang tool implementatino is explained in#  introducing the "SC2InfoExtractorGo". Finally, data modeling or post-processing tasks are introduced in#  diving deeper on "SC2_Datasets" as a Python API implementations for PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019].

![Simplified full pipeline using SC2Tools to create two datasets, "SC2ReSet" [@Bialecki2022ReSetZenodo] and "SC2EGSet" Dataset [@Bialecki2023EGSetZenodo]. Initially introduced in [@Bialecki2023SC2EGSet]. \label{fig:DatasetPipeline}](SC2Tools_Pipeline_Complete.pdf)

### DatasetPreparator

The "DatasetPreparator" [@Bialecki_2022_SC2DatasetPreparator] submodule is a set of scripts that ease the process of working with major collections of raw data (replaypacks/datasets). A full list of scripts is as follows:
  1. "directory_flattener.py";&nbsp;flattens the nested directory structure of the replaypacks,
  2. "directory_packager.py";&nbsp;packages all of the directories in the specified input directory,
  3. "file_renamer.py";&nbsp;renames the files in the directory to follow a specific naming convention (e.g., to match the dataset schema),
  4. "json_merger.py";&nbsp;merges two JSON files into one,
  5. "processed_mapping_copier.py";&nbsp;copies the auxiliary files generated by "directory_flattener.py" to matching output directories. Built specifically to prepare the "SC2EGSet" prior to packaging,
  6. "sc2_map_downloader.py";&nbsp;wraps "SC2InfoExtractorGo" to run the map downloading step,
  7. "sc2egset_replaypack_processor.py";&nbsp;wraps "SC2InfoExtractorGo" to run the replaypack processing step on multiple directories at once,
  8. "sc2egset_pipeline.py";&nbsp;wraps the entire processing pipeline used to obtain the "SC2ReSet" and "SC2EGSet" datasets,
  9. "sc2reset_replaypack_downloader.py";&nbsp;downloads the raw (flattened) replaypacks of "SC2ReSet" [@Bialecki2022ReSetZenodo] for users that wish to use their own tools for data processing.

In the context of our work, this submodule is responsible for preparing directory structure, execution of "SC2InfoExtractorGo" on the data, and packaging the dataset for hosting. Finally, the current capabilities include downloading the raw replaypacks of "SC2ReSet" [@Bialecki2022ReSetZenodo] for ease of "SC2EGSet" Dataset reproduction [@Bialecki2023EGSetZenodo].

### SC2InfoExtractorGo

The SC2InfoExtractorGo as a submodule is a tool responsible for extracting the data from SC2Replay files, it depends on previously published open-source lower-level libraries [@URLS2Prot2016,@URLMPQ2017]. The tool is written in Golang and is shipped as a binary file (release), and as a Docker image via DockerHub. A simplified depiction of the data extraction is available on \autoref{fig:file_processing_sc2infoextractorgo}.

![Pictorial representation of the "SC2InfoExtractorGo" functionality [@Bialecki_2021_SC2InfoExtractorGo]. Replays contain the events which happened during gameplay (blue background), our implementations extracts this data and outputs it for further analysis by the user (orange background). \label{fig:file_processing_sc2infoextractorgo}](server_to_json.pdf)

### SC2_Datasets

One of our solutions, SC2_Datasets [@bialecki_2022_sc2datasets] interfaces with the JSON files produced by the SC2InfoExtractorGo [@Bialecki_2021_SC2InfoExtractorGo]. This includes all of the classes and methods required to load a single JSON, a collection of JSON files (representing a replaypack), and finally a way of loading an entire dataset (a collection of replaypacks). The pictorial representation of the "SC2_Datasets" functionality is presented on \autoref{fig:LoadingDataToPyTorch}.

![Loading the output of the SC2InfoExtractorGo for machine learning and artificial intelligence use with "SC2_Datasets". \label{fig:LoadingDataToPyTorch}](SC2Tools_ExperimentWorkflow.pdf)


Users have the ability to extend our solution and apply it to their data via the PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019] interfaces.

## {SC2AnonServerPy}

In the process of extracting the information from the StarCraft&nbsp;2 replays, the users have the ability to choose if nicknames of the players should be anonymized with a separate tool "SC2AnonServerPy" [@Bialecki_2021_SC2AnonServerPy], this functionality may be key for laboratories that wish to share their datasets with a wider community.

## {Software Functionalities}

Main functionality of this software collection introduce a repeatable way of working with StarCraft 2 data for research and data analysis. Users need to verify if their specific use case is permitted by the Blizzard End User License Agreement (EULA). Our software package includes file-wrangling tools such as: flattening nested directory structure, data-parallel replay file parsing (extraction), data cleanup, exporting replay data to JSON, and finally data loading into PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019]. We have developed a modular system of tools solving specific issues of data processing with expandability in mind.

Main contribution of the work that we present is the "SC2InfoExtractorGo" [@Bialecki_2021_SC2InfoExtractorGo], as introduced above. The most important procedure of the data extraction pipeline is showcased in \autoref{fig:file_processing_pseudocode}.

Within "DatasetPreparator" [@Bialecki_2022_SC2DatasetPreparator] there are multiple scripts that solve specific problems that may be present when researching StarCraft&nbsp;2, including a wrapper for the "SC2InfoExtractorGo". For example to reproduce the "SC2ReSet" and "SC2EGSet", scripts from "DatasetPreparator" would be executed consecutively as follows:
 1. "directory_flattener.py" to flatten the nested directory structure of replaypacks that often have a complex structure with meaningful directory naming conventions,
 2. "directory_packager.py" to obtain "SC2ReSet" by creating archives of the previously flattened directories,
 3. "sc2egset_replaypack_processor.py" (requires "SC2InfoExtractorGo") to process the replaypacks and obtain the initial version of "SC2EGSet",
 4. "processed_mapping_copier.py" to copy the auxiliary files generated by "directory_flattener.py" to matching output directories.
 5. "file_renamer.py" to rename the files in directories to follow a specific naming convention (e.g., to match the dataset schema),
 6. "directory_packager.py" to obtain the final version of "SC2EGSet" by packaging all of the directories in the specified input directory.


## Code Snippets


Due to the complex nature of our software, and number of operations that are run for every replay, we have created multiple functions that define the steps of the data extraction process with "SC2InfoExtractorGo". Function that is ran for every replay is showcased in \autoref{fig:file_processing_pseudocode}.

![Golang-inspired pseudocode algorithm for processing a single replay file using SC2InfoExtractorGo [@Bialecki_2021_SC2InfoExtractorGo]. \label{fig:file_processing_pseudocode}](file_processing_pipeline.png)

After the initial processing with a pre-defined pipeline, the output JSON files can be loaded with any programming language capable of reading this format for further processing. In our case this is showcased in "SC2_Datasets" repository, building on top of the JSON files an API for rapid experimentation with ML and AI methods using PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019].

# Usage Information

## DatasetPreparator

### Usage of Directory Flattener

It is common for StarCraft 2 tournament replaypacks to be sorted in multiple subdirectories. There is some information to be inferred from the names of the directories. Using this script flattens the diectory structure and prepares it for a simplified further processing.

### Usage of Directory Packager

Finally, after all of the replaypack, or dataset processing is done, we have prepared a utility script that creates a ".zip" archive out of all top-level directories.

### Usage of Processed Mapping Copier and File Renamer

As described above, after using the "directory_flattener.py" script, one of its side effects is the creation of "processed_mapping.json" file. When preparing a dataset, these files can be treated as additional metadata. Our software in its pipeline includes a script called "processed_mapping_copier.py", it iterates over each of the input directories and matches it against the directory in the output directory and copies the "processed_mapping.json" file.

To facilitate dataset creation, in most cases replaypack directories are often named after the tournament at which they were collected. File renaming script makes sure that the resulting ".zip" archive is renamed to match the tournament name. Some additional auxilliary files are created. This includes: (1) package summaries; containing some basic information about the number of processed replays and other in-game information. (2) previously copied "processed_mapping.json" file considering the directory structure of a replaypack might have been flattened. (3) "processed_failed.log" file containing the information about which files failed to process, and which files were processed successfully. (4) "main_log.log" file, containing all of the logs for debugging.
In case of all of these files the "file_renamer.py" unifies the file names to become prepended with the tournament name e.g., "main_log.log" file becomes "TournamentName2024_main_log.log".

### Usage of SC2EGSet Dataset Processing Pipeline


One of the scripts ("sc2egset_pipeline.py") simplifies all of the steps required to produce a StarCraft&nbsp;2 dataset. We use this code to easily reproduce "SC2ReSet", and "SC2EGSet".


## SC2EGSet Replaypack Processor

For a user that wishes to reproduce "SC2EGSet" from "SC2ReSet", a separate script is available that runs multiple instances of SC2InfoExtractorGo, The script iterates over each of the directory in the input path, and runs the "SC2InfoExtractorGo" on each of them with hardcoded parameters. Our solution implements multiprocessing Besides this functionality, the script does not offer much more utility than the original "SC2InfoExtractorGo" executable.


### Usage of Other Scripts

Using the "sc2reset_replaypack_downloader.py" via its command line arguments makes it is possible to download all available replaypacks published as "SC2ReSet" hosted in an Zenodo repository [@Bialecki2022ReSetZenodo]. When using "SC2ReSet" to run the rest of the processing pipeline, there is no need to execute the "directory_flattener.py", each replaypack was pre-processed before upload. After downloading "SC2ReSet" [@Bialecki2022ReSetZenodo], it should be available under the directory as specified by the user.

## Direct Use of SC2InfoExtractorGo

Next step pertains to the data extraction with "SC2InfoExtractorGo". The input directory for the command line usage of "SC2InfoExtractorGo" should reflect the directory where the user stored the replays which they would like to process. To ensure smooth reproduction of SC2EGSet the "SC2InfoExtractorGo" should be ran against each of the replaypack directories separately to produce output corresponding to data from a single tournament.


## Usage of SC2AnonServerPy

In some cases, the user might want to anonymize the data due to the privacy, ethical, or legislative concerns. We provide additional service named "SC2AnonServerPy". As a separate gRPC service it is capable of receiving a string type containing a player nickname, and return a unique identifier as a string type for the requested player. The anonymization server is not constrained to StarCraft&nbsp;2 data and can be used as long as the user provides the expected input type.


## Running Experiments With SC2_Datasets

After extracting the data from SC2Replay files, any further processing, and experiments are possible with the "SC2_Datasets" Python package [@bialecki_2022_sc2datasets]. Loading a single JSON file following the structure defined in the "SC2_Datasets" parser can be seen on \autoref{fig:single_json}. To load the output of a processed dataset that exists either on the drive or online, the user should initialize a class as visualized on \autoref{fig:pytorch_dataset_custom}. Additionally, PyTorch Lightning [@PyTorch_Lightning_2019] datamodule interfaces can be used as they are included in the API Note that the users have full control and customizability of the code. In case of our implementations for "SC2EGSet" we provide an interface to use the data. Similar approach can be used with data from other sources, as long as the data is formatted in a way that is compatible with the "SC2_Datasets" parser.

![Pictorial representation of code used to load a single replay, as defined in [@bialecki_2022_sc2datasets]. \label{fig:single_json}](loading_replay_data.png)

![Example usage of the PyTorch [@PyTorch2019] dataset interface as defined in [@bialecki_2022_sc2datasets]. \fig:pytorch_dataset_custom](custom_pytorch_dataset_loading.png)

# Potential Impact

There exist many implementations built for the purpose of parsing replay files [@ZenodoSC2Reader]. These tools and libraries require expert programming skills to extract and interact with the resulting data. Many research approaches involve scientists that may not posses such expert knowledge in programming, but nonetheless interested in investigating esports (e.g., in psychology, biomechanics, social sciences and humanities -- SSH, and others) [@Kegelaers2025,@Dupuy2025,@Donghee2020]. Lowering the technical overhead needed to interact with in-game data can open gaming and esports to researchers with various non-technical backgrounds. Furthermore, integrating SSH scientists in the research process is not only a requirement in some funding programs, but also a practical necessity, if one aims to conduct socially responsible studies [@graf2019bringing,@sonetti2020only].

Before introducing our software, users were bound to write their own tools extracting the data from StarCraft 2 replay files. Our solution outputs easy-to-use JSON files adhering to a specific, well-documented schema definition [https://sc2-datasets.readthedocs.io/en/latest/autoapi/index.html](https://sc2-datasets.readthedocs.io/en/latest/autoapi/index.html). Additionally, the data extraction toolset efficiently leverages modern multi-core processors (using Golang goroutines), making the process of data extraction faster. This has real implications on day-to-day research, as it allows for faster experimentation and iteration on one's methods.

Within the intended user group, the software was created to assist with the process of StarCraft 2 data processing. Mainly, the software fulfilled the research needs of our team and other collaborating research teams, which led to processing and creating a dataset [@Bialecki2023SC2EGSet]. Additionally, an API interface was created to load and work with the data in PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019].

Due to the End User License Agreement (EULA) provisions specified by the game publisher (Blizzard), the commercial use of the extracted game data directly is limited. Nonetheless, one can extract valuable insights from the data and transfer them to the industry in a manner compliant with the EULA. In the past, research conducted on StarCraft&nbsp;2 data has yielded fruitful ventures in online tooling [@URLSc2replaystats,@URLSpawningTool,@URLSC2Revealed,@URLAligulac], and research [@Vinyals2019,@Ma2024LLMStarCraft2,@Samvelyan2019SMAC,@Ferenczi2024sc2_serizlizer].

# Conclusions

We conclude that despite there being some software packages available, they often require additional programming skills and knowledge. Our solution provides a simple to use executable file and a set of scripts to work with StarCraft 2 data. Additionally, we conclude that our software solves a very specific infrastructure problem that is prevalent in the gaming and esports research on StarCraft&nbsp;2.

In its current version our toolset "SC2Tools" is capable of simplifying the work associated with handling files used to create a StarCraft&nbsp;2 dataset. We are planning to keep updating the software to include more tools, features, and functionalities. Additionally, due to the capability of our software to output JSON files, We claim full interoperability with other replay parsing solutions as long as they keep the same output format.

Finally, based on our previous experience in successfully creating a published dataset that was leveraged in other published material [@Ferenczi2024sc2_serizlizer], we conclude that our efforts were not in vain and such infrastructure development may be useful to others.

# Conflict of Interest

We wish to confirm that there are no known conflicts of interest associated with this publication and there has been no significant financial support for this work that could have influenced its outcome.

# Acknowledgements

We would like to acknowledge various contributions by the members of the technical and research community, with special thanks to: Timo Ewalds (DeepMind, Google), Anthony Martin (Sc2ReplayStats), and András Belicza for assisting with our technical questions.
