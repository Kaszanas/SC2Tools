---
title: "SC2Tools: StarCraft II Toolset and Dataset API"
tags:
  - esport
  - data processing
  - toolset
  - dataset preparation

authors:
  - name: Andrzej Białecki
    orcid: 0000-0003-3668-4638
    affiliation: '1, 4'

  - name: Piotr Białecki
    orcid: 0009-0003-1185-1441
    affiliation: '5'

  - name: Piotr Sowiński
    orcid: 0000-0002-2543-9461
    affiliation: '1, 3'

  - name: Mateusz Budziak
    affiliation: '5'

  - name: Jan Gajewski
    orcid: 0000-0002-2146-6198
    affiliation: '2'


affiliations:
  - index: 1
    name: Warsaw University of Technology, Poland
  - index: 2
    name: Józef Piłsudski University of Physical Education in Warsaw, Poland
  - index: 3
    name: NeverBlink, Poland
  - index: 4
    name: HealthyGG
  - index: 5
    name: Independent Researcher

date: 09 May 2025
bibliography: ./article/paper.bib
---

# Summmary

Computer games, as fully controlled simulated environments, have been utilized in significant scientific studies demonstrating the application of Reinforcement Learning (RL). Gaming and esports are key areas influenced by the application of Artificial Intelligence (AI) and Machine Learning (ML) solutions at scale. Tooling simplifies scientific workloads and is essential for developing the gaming and esports research area. Our tools primarily deliver software for working with StarCraft&nbsp;2, a well-known real-time strategy (RTS) game and one of the long-standing esports titles.

In this work, we present "SC2Tools", a toolset containing multiple submodules responsible for working with, and producing larger StarCraft&nbsp;2 datasets. We provide a modular structure of the implemented tooling, leaving room for future extensions where needed. Additionally, some of the tools are not StarCraft&nbsp;2 exclusive and can be used with other types of data for dataset creation. We provide PyTorch and PyTorch Lightning application programming interface (API) for easy access to the data. Finally, our solution provides some foundational work toward normalizing experiment workflow in StarCraft&nbsp;2

# Introduction and Background

Computer games as fully controlled simulated environments were used in major scientific works that showcased the application of Reinforcement Learning (RL). As such, computer games can be viewed as one of the many components of major breakthroughs and advancements in RL applications [@Szita2012RLGames;@Samsuden2019RLGames;@LanctotEtAl2019OpenSpiel;@Shao2019RLSurvey;@Jayaramireddy2023RLSurvey;@Vinyals2019;@Wurman2022].

Despite heightened interest in research on gaming and esports, there are limited high-level libraries and tools made for rapid experimentation in some game titles. Researchers from various research disciplines have shown their interest in exploring gaming and esports, including: (1) psychology [@Campbell2018], (2) computer science [@Rashid2020;@Yuan2021ActorCritic], (3) education [@Jensen2024;@Jenny2021], (4) medical sciences [@Krarup2020109344], and others [@Holden2017Law;@Nagorsky2020].
The ability to tie these topics with the in-game data cannot be overstated.

When such software is available, it is often hard to use for less technically proficient researchers. Data parsing libraries are prevalent in computer games, such as Counter-Strike [@AWPYXeno2020;@ClarityGitHub], Rocket&nbsp;League [@URLBoxcars2016], Dota&nbsp;2 [@OpenDotaGitHub;@ClarityGitHub], and finally in StarCraft&nbsp;2 [@URLBlizzardS2ClientProto;@URLS2Prot2016;@GitHubSC2Reader].

Esports can be treated as a subset of gaming with additional requirements for players, such as tournament presence, organized play, training, and professionalization [@Formosa2022]. The study of esports is multidisciplinary in nature [@Brock2023Interdisciplinary;@Pizzo2022Interdisciplinary]. Due to the growing academic interest in the area of gaming and esports [@Yamanaka2021Review;@Reitman2020Review;@Tang2023Review;@Bialecki2024Review], it is key to provide tools for researchers capable of simplifying the process of acquiring large datasets efficiently, not only for authors interested in the area of computer science [@Ferenczi2024sc2_serizlizer;@SmerdovLoLDataset2021].

We focus on solving problems within the StarCraft&nbsp;2 (SC2) infrastructure ecosystem. We solve the problem of ease of access to the data encoded in files with ".SC2Replay". StarCraft&nbsp;2 is a real-time strategy game developed by Blizzard Entertainment. The game is known as one of the most prominent real-time strategy (RTS) esports titles [@Tyreal2020;@Dal2020]. It is also characterized by its fast-paced gameplay and a high skill ceiling [@Migliore2021]. These attributes make for a great environment for testing various AI agents [@Ma2024LLMStarCraft2,@Vinyals2019;@Samvelyan2019SMAC;@Pearce2022CSGO]. Moreover, research in StarCraft&nbsp;2 is not limited to AI agents -- there are efforts to analyze the game from various perspectives and provide insights that can assist players in their gameplay [@URLSC2AICoach2022LLM;@URLSc2replaystats].

So far, our software was leveraged in preparation of major datasets: "SC2ReSet" [@Bialecki2022ReSetZenodo] and "SC2EGSet" [@Bialecki2023EGSetZenodo] with an accompanying peer-reviewed and published Data Descriptor article [@Bialecki2023SC2EGSet]. Our goal for this work was to lower the technical knowledge required to obtain data from in-game replays.

# Software Description

Our software consists of multiple modules that the user can match to their specific needs. To easily extend our toolset, the main repository of "SC2Tools" contains multiple git submodules. Each submodule is a separate repository with the logic required to perform a specific tasks on the SC2Replay files. The full pipeline in a simplified pictorial form is showcased in \autoref{fig:DatasetPipeline}. The motivation for this structure is twofold. Firstly, it makes evolving the toolset easier, as modules can be easily replaced, or new ones added. Secondly, users have the option of using only a portion of the pipeline. The full list of current submodules is as follows: (1) "DatasetPreparator" [@Bialecki_2022_SC2DatasetPreparator], (2) "SC2InfoExtractorGo" [@Bialecki_2021_SC2InfoExtractorGo], (3) "SC2AnonServerPy" [@Bialecki_2021_SC2AnonServerPy]. (4) "SC2_Datasets" [@bialecki_2022_sc2datasets].

![Simplified full pipeline using SC2Tools to create two datasets, "SC2ReSet" [@Bialecki2022ReSetZenodo] and "SC2EGSet" Dataset [@Bialecki2023EGSetZenodo]. Initially introduced in [@Bialecki2023SC2EGSet]. \label{fig:DatasetPipeline}](./article/SC2Tools_Pipeline_Complete.pdf)

## DatasetPreparator

The "DatasetPreparator" [@Bialecki_2022_SC2DatasetPreparator] submodule is a set of scripts that ease the process of working with major collections of raw data (replaypacks/datasets). A full list of scripts is as follows: (1) "directory_flattener.py"; flattens the nested directory structure of the replaypacks, (2) "directory_packager.py"; packages all of the directories in the specified input directory, (3) "file_renamer.py"; renames the files in the directory to follow a specific naming convention (e.g., to match the dataset schema), (4) "json_merger.py"; merges two JSON files into one, (5) "processed_mapping_copier.py"; copies the auxiliary files generated by directory_flattener.py to matching output directories. Built specifically to prepare the SC2EGSet prior to packaging, (6) "sc2_map_downloader.py"; wraps "SC2InfoExtractorGo" to run the map downloading step, (7) "sc2egset_replaypack_processor.py"; wraps "SC2InfoExtractorGo" to run the replaypack processing step on multiple directories at once, (8) "sc2egset_pipeline.py"; wraps the entire processing pipeline used to obtain the "SC2ReSet" and "SC2EGSet" datasets, (9) "sc2reset_replaypack_downloader.py"; downloads the raw (flattened) replaypacks of "SC2ReSet" [@Bialecki2022ReSetZenodo] for users that wish to use their own tools for data processing.

In the context of our work, this submodule is responsible for preparing directory structure, execution of "SC2InfoExtractorGo" on the data, and packaging the dataset for hosting. Finally, the current capabilities include downloading the raw replaypacks of "SC2ReSet" [@Bialecki2022ReSetZenodo] for ease of "SC2EGSet" Dataset reproduction [@Bialecki2023EGSetZenodo].


## SC2InfoExtractorGo

The SC2InfoExtractorGo as a submodule is a tool responsible for extracting the data from SC2Replay files, it depends on previously published open-source lower-level libraries [@URLS2Prot2016;@URLMPQ2017]. The tool is written in Golang and is shipped as a binary file (release), and as a Docker image via DockerHub. A simplified depiction of the data extraction is available on \autoref{fig:file_processing_sc2infoextractorgo}.

![Pictorial representation of the "SC2InfoExtractorGo" functionality [@Bialecki_2021_SC2InfoExtractorGo]. Replays contain the events which happened during gameplay (blue background), our implementations extracts this data and outputs it for further analysis by the user (orange background). \label{fig:file_processing_sc2infoextractorgo}](./article/server_to_json.pdf)

## SC2AnonServerPy

In the process of extracting the information from the StarCraft~2 replays, the users have the ability to choose if nicknames of the players should be anonymized with a separate tool "SC2AnonServerPy" [@Bialecki_2021_SC2AnonServerPy], this functionality may be key for laboratories that wish to share their datasets with a wider community. The "SC2AnonServerPy" repository contains a gRPC [@gRPC2014] service that acquires a weakly anonymized unique identifier for the players that participated in the game. Other implementations and tools may be added in the future to further anonymize the data.

## SC2_Datasets

One of our solutions, SC2_Datasets [@bialecki_2022_sc2datasets] interfaces with the JSON files produced by the SC2InfoExtractorGo [@Bialecki_2021_SC2InfoExtractorGo]. This includes all of the classes and methods required to load a single JSON, a collection of JSON files (representing a replaypack), and finally a way of loading an entire dataset (a collection of replaypacks). The pictorial representation of the "SC2_Datasets" functionality is presented on \autoref{fig:LoadingDataToPyTorch}.

![Loading the output of the SC2InfoExtractorGo for machine learning and artificial intelligence use with "SC2_Datasets". \label{fig:LoadingDataToPyTorch}](./article/SC2Tools_ExperimentWorkflow.pdf)

Users have the ability to extend our solution and apply it to their data via the PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019] interfaces.


## Software Functionalities

Main functionality of this software collection introduce a repeatable way of working with StarCraft&nbsp;2 data for research and data analysis. Users need to verify if their specific use case is permitted by the Blizzard End User License Agreement (EULA). Our software package includes file-wrangling tools such as: flattening nested directory structure, data-parallel replay file parsing (extraction), data cleanup, exporting replay data to JSON, and finally data loading into PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019]. We have developed a modular system of tools solving specific issues of data processing with expandability in mind.


# Statement of Need

The need for similar solutions is clear, output of this software or related artifacts were used directly in varying contexts, the community cited our work, some authors following the general flow of our exploration [@Kim2024;@Ferenczi2024sc2_serizlizer]. Presented software was created to assist with the process of StarCraft&nbsp;2 data processing. Mainly, the software fulfilled the research needs of our team, other collaborating research teams, and the scientific community as a whole. Additionally, as a result, the software was used to process and create a dataset shared openly [@Bialecki2023SC2EGSet]. Finally, an API interface was created to load and work with the data in PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019].

There exist many implementations built for the purpose of parsing replay files [@ZenodoSC2Reader]. These tools and libraries require expert programming skills to extract and interact with the resulting data. Many research approaches involve scientists that may not posses such expert knowledge in programming, but nonetheless interested in investigating esports (e.g., in psychology, biomechanics, social sciences and humanities -- SSH, and others) [@Kegelaers2025;@Dupuy2025;@Donghee2020]. Lowering the technical overhead needed to interact with in-game data can open gaming and esports to researchers with various non-technical backgrounds. Furthermore, integrating SSH scientists in the research process is not only a requirement in some funding programs, but also a practical necessity, if one aims to conduct socially responsible studies [@graf2019bringing;@sonetti2020only].

Before introducing our software, users were bound to write their own tools extracting the data from StarCraft&nbsp;2 replay files. Our solution outputs easy-to-use JSON files adhering to a specific, well-documented schema definition [https://sc2-datasets.readthedocs.io/en/latest](https://sc2-datasets.readthedocs.io/en/latest). Additionally, the data extraction toolset efficiently leverages modern multi-core processors (using Golang goroutines), making the process of data extraction faster. This has real implications on day-to-day research, as it allows for faster experimentation and iteration on one's methods. Finally, In the past, research conducted on StarCraft&nbsp;2 data has yielded fruitful ventures in online tooling [@URLSc2replaystats;@URLSpawningTool;@URLSC2Revealed;@URLAligulac]; and research [@Vinyals2019;@Ma2024LLMStarCraft2;@Samvelyan2019SMAC;@Ferenczi2024sc2_serizlizer].

# Conclusions

We conclude that despite there being some software packages available, they often require additional programming skills and knowledge. Our solution provides a simple to use executable file and a set of scripts to work with StarCraft&nbsp;2 data. Additionally, we conclude that our software solves a very specific infrastructure problem that is prevalent in the gaming and esports research on StarCraft&nbsp;2.

In its current version our toolset "SC2Tools" is capable of simplifying the work associated with handling files used to create StarCraft&nbsp;2 datasets. We are planning to keep updating the software to include more tools, features, and functionalities. Additionally, due to the capability of our software to output JSON files, We claim full interoperability with other replay parsing solutions as long as they keep the same output format.

# Conflict of Interest

We wish to confirm that there are no known conflicts of interest associated with this publication and there has been no significant financial support for this work that could have influenced its outcome.

# Acknowledgements

We would like to acknowledge various contributions by the members of the technical and research community, with special thanks to: Timo Ewalds (DeepMind, Google), Anthony Martin (Sc2ReplayStats), and András Belicza for assisting with our technical questions.

# References