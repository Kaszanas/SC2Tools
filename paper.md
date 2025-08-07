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
    affiliation: '1'

  - name: Piotr Białecki
    orcid: 0009-0003-1185-1441
    affiliation: '2'

  - name: Piotr Sowiński
    orcid: 0000-0002-2543-9461
    affiliation: '1, 4'

  - name: Mateusz Budziak
    affiliation: '2'

  - name: Jan Gajewski
    orcid: 0000-0002-2146-6198
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

date: 09 May 2025
bibliography: ./article/paper.bib
---



# Introduction and Background

Computer games as fully controlled simulated environments were used in major scientific works that showcased the application of Reinforcement Learning (RL). As such, computer games can be viewed as one of the many components of major breakthroughs and advancements in RL applications [@Szita2012RLGames;@Samsuden2019RLGames;@LanctotEtAl2019OpenSpiel;@Shao2019RLSurvey;@Jayaramireddy2023RLSurvey;@Vinyals2019;@Wurman2022].

Despite heightened interest in research on gaming and esports, there are limited high-level libraries and tools made for rapid experimentation in some game titles. Researchers from various research disciplines have shown their interest in exploring gaming and esports, including: (1) psychology [@Campbell2018], (2) computer science [@Rashid2020;@Yuan2021ActorCritic], (3) education [@Jensen2024;@Jenny2021], (4) medical sciences [@Krarup2020109344], and others [@Holden2017Law;Nagorsky2020].
The ability to tie these topics with the in-game data cannot be overstated.

When such software is available, it is often hard to use for less technically proficient researchers. Data parsing libraries are prevalent in computer games, such as Counter-Strike [@AWPYXeno2020;@ClarityGitHub], Rocket&nbsp;League [@URLBoxcars2016], Dota&nbsp;2 [@OpenDotaGitHub;@ClarityGitHub], and finally in StarCraft&nbsp;2 [@URLBlizzardS2ClientProto;@URLS2Prot2016;@GitHubSC2Reader].

Esports can be treated as a subset of gaming with additional requirements for players, such as tournament presence, organized play, training, and professionalization [@Formosa2022]. The study of esports is multidisciplinary in nature [@Brock2023Interdisciplinary;@Pizzo2022Interdisciplinary]. Due to the growing academic interest in the area of gaming and esports [@Yamanaka2021Review;@Reitman2020Review;@Tang2023Review;@Bialecki2024Review], it is key to provide tools for researchers capable of simplifying the process of acquiring large datasets efficiently, not only for authors interested in the area of computer science [@Ferenczi2024sc2_serizlizer;@SmerdovLoLDataset2021].

We focus on solving problems within the StarCraft&nbsp;2 (SC2) infrastructure ecosystem. We solve the problem of ease of access to the data encoded in files with ".SC2Replay". StarCraft&nbsp;2 is a real-time strategy game developed by Blizzard Entertainment. The game is known as one of the most prominent real-time strategy (RTS) esports titles [@Tyreal2020;Dal2020]. It is also characterized by its fast-paced gameplay and a high skill ceiling [@Migliore2021]. These attributes make for a great environment for testing various AI agents [@Ma2024LLMStarCraft2,@Vinyals2019;@Samvelyan2019SMAC;@Pearce2022CSGO]. Moreover, research in StarCraft&nbsp;2 is not limited to AI agents -- there are efforts to analyze the game from various perspectives and provide insights that can assist players in their gameplay [@URLSC2AICoach2022LLM;@URLSc2replaystats].

So far, our software was leveraged in preparation of major datasets: "SC2ReSet" [@Bialecki2022ReSetZenodo] and "SC2EGSet" [@Bialecki2023EGSetZenodo] with an accompanying peer-reviewed and published Data Descriptor article [@Bialecki2023SC2EGSet]. Our goal for this work was to lower the technical knowledge required to obtain data from in-game replays.

# Software Description

Our software consists of multiple modules that the user can match to their specific needs. To easily extend our toolset, the main repository of "SC2Tools" contains multiple git submodules. Each submodule is a separate repository with the logic required to perform a specific tasks on the SC2Replay files. The full pipeline in a simplified pictorial form is showcased in \autoref{fig:DatasetPipeline}. The motivation for this structure is twofold. Firstly, it makes evolving the toolset easier, as modules can be easily replaced, or new ones added. Secondly, users have the option of using only a portion of the pipeline. The full list of current submodules is as follows: (1) "SC2InfoExtractorGo" [@Bialecki_2021_SC2InfoExtractorGo], (2) "DatasetPreparator" [@Bialecki_2022_SC2DatasetPreparator], (3) "SC2AnonServerPy" [@Bialecki_2021_SC2AnonServerPy]. (4) "SC2_Datasets" [@bialecki_2022_sc2datasets].

![Simplified full pipeline using SC2Tools to create two datasets, "SC2ReSet" [@Bialecki2022ReSetZenodo] and "SC2EGSet" Dataset [@Bialecki2023EGSetZenodo]. Initially introduced in [@Bialecki2023SC2EGSet]. \label{fig:DatasetPipeline}](./article/SC2Tools_Pipeline_Complete.pdf)


### SC2InfoExtractorGo

The SC2InfoExtractorGo as a submodule is a tool responsible for extracting the data from SC2Replay files, it depends on previously published open-source lower-level libraries [@URLS2Prot2016;@URLMPQ2017]. The tool is written in Golang and is shipped as a binary file (release), and as a Docker image via DockerHub. A simplified depiction of the data extraction is available on \autoref{fig:file_processing_sc2infoextractorgo}.

![Pictorial representation of the "SC2InfoExtractorGo" functionality [@Bialecki_2021_SC2InfoExtractorGo]. Replays contain the events which happened during gameplay (blue background), our implementations extracts this data and outputs it for further analysis by the user (orange background). \label{fig:file_processing_sc2infoextractorgo}](./article/server_to_json.pdf)

### SC2_Datasets

One of our solutions, SC2_Datasets [@bialecki_2022_sc2datasets] interfaces with the JSON files produced by the SC2InfoExtractorGo [@Bialecki_2021_SC2InfoExtractorGo]. This includes all of the classes and methods required to load a single JSON, a collection of JSON files (representing a replaypack), and finally a way of loading an entire dataset (a collection of replaypacks). The pictorial representation of the "SC2_Datasets" functionality is presented on \autoref{fig:LoadingDataToPyTorch}.

![Loading the output of the SC2InfoExtractorGo for machine learning and artificial intelligence use with "SC2_Datasets". \label{fig:LoadingDataToPyTorch}](SC2Tools_ExperimentWorkflow.pdf)

Users have the ability to extend our solution and apply it to their data via the PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019] interfaces.


## Software Functionalities

Main functionality of this software collection introduce a repeatable way of working with StarCraft 2 data for research and data analysis. Users need to verify if their specific use case is permitted by the Blizzard End User License Agreement (EULA). Our software package includes file-wrangling tools such as: flattening nested directory structure, data-parallel replay file parsing (extraction), data cleanup, exporting replay data to JSON, and finally data loading into PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019]. We have developed a modular system of tools solving specific issues of data processing with expandability in mind.


# Statement of Need

The need for similar solutions is clear, output of our software was used in varying contexts, authors cited our work, some of them following the general flow of our exploration [@Kim2024;@Ferenczi2024sc2_serizlizer]. Within the intended user group, the software was created to assist with the process of StarCraft 2 data processing. Mainly, the software fulfilled the research needs of our team and other collaborating research teams, which led to processing and creating a dataset [@Bialecki2023SC2EGSet]. Additionally, an API interface was created to load and work with the data in PyTorch [@PyTorch2019] and PyTorch Lightning [@PyTorch_Lightning_2019].

There exist many implementations built for the purpose of parsing replay files [@ZenodoSC2Reader]. These tools and libraries require expert programming skills to extract and interact with the resulting data. Many research approaches involve scientists that may not posses such expert knowledge in programming, but nonetheless interested in investigating esports (e.g., in psychology, biomechanics, social sciences and humanities -- SSH, and others) [@Kegelaers2025;@Dupuy2025;@Donghee2020]. Lowering the technical overhead needed to interact with in-game data can open gaming and esports to researchers with various non-technical backgrounds. Furthermore, integrating SSH scientists in the research process is not only a requirement in some funding programs, but also a practical necessity, if one aims to conduct socially responsible studies [@graf2019bringing;@sonetti2020only].

Before introducing our software, users were bound to write their own tools extracting the data from StarCraft 2 replay files. Our solution outputs easy-to-use JSON files adhering to a specific, well-documented schema definition [https://sc2-datasets.readthedocs.io/en/latest/autoapi/index.html](https://sc2-datasets.readthedocs.io/en/latest/autoapi/index.html). Additionally, the data extraction toolset efficiently leverages modern multi-core processors (using Golang goroutines), making the process of data extraction faster. This has real implications on day-to-day research, as it allows for faster experimentation and iteration on one's methods. Finally, In the past, research conducted on StarCraft&nbsp;2 data has yielded fruitful ventures in online tooling [@URLSc2replaystats;@URLSpawningTool;@URLSC2Revealed;@URLAligulac]; and research [@Vinyals2019;@Ma2024LLMStarCraft2;@Samvelyan2019SMAC;@Ferenczi2024sc2_serizlizer].

# Conclusions

We conclude that despite there being some software packages available, they often require additional programming skills and knowledge. Our solution provides a simple to use executable file and a set of scripts to work with StarCraft 2 data. Additionally, we conclude that our software solves a very specific infrastructure problem that is prevalent in the gaming and esports research on StarCraft&nbsp;2.

In its current version our toolset "SC2Tools" is capable of simplifying the work associated with handling files used to create StarCraft&nbsp;2 datasets. We are planning to keep updating the software to include more tools, features, and functionalities. Additionally, due to the capability of our software to output JSON files, We claim full interoperability with other replay parsing solutions as long as they keep the same output format.

# Conflict of Interest

We wish to confirm that there are no known conflicts of interest associated with this publication and there has been no significant financial support for this work that could have influenced its outcome.

# Acknowledgements

We would like to acknowledge various contributions by the members of the technical and research community, with special thanks to: Timo Ewalds (DeepMind, Google), Anthony Martin (Sc2ReplayStats), and András Belicza for assisting with our technical questions.
