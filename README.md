# Introduction

This repository provides a comprehensive evaluation of all tools and reproduces the results from the EquiRep paper. The official EquiRep repository can be found [here](https://github.com/Shao-Group/EquiRep).

# Data

All simulated and real data used in the experiments are available in the `data` directory.

`simulated_data`: `dat3` contains the randomly simulated data of different unit lengths and copy numbers. `dat_aax2` contains simulated sequences with 2 recurring kmers. `dat_aax3` contains simulated sequences with 3 recurring kmers. `error_10` and `error_20` inside each of these folders represent error rates of 10% and 20% respectively.

`HOR_data`: `hor_repeats.fasta` contains the 13 Higher Order Repeat sequences from human chromosome 5. `hor_combined.fasta` contains the concatenated sequences (x), concatenated sequences with flanking regions (axa), and error rate of 1%, 5%, 10% applied to them (x_err1, x_err5, x_err10, axa_err1, axa_err5, axa_err10).

`RCA_data`: `RCA_101.fasta` contains selected 101 Nanopore long read sequences from human prostate tissue (GEO, accession number: GSE141693).

# EquiRep

## Installation
No external installation is required. The source code for EquiRep is provided in this repository at `EquiRep_test/EquiRep.cpp`.

## Running experiments on simulated data
1. Navigate to the EquiRep Testing Folder: 
	```
	cd EquiRep_test
	```
2. Change `exec.sh` to select the dataset you'd like to use (options are dat3, dat_aax2, or dat_aax3):
	```
	input_dir_prefix=../data/simulated_data/dat3
	# Replace dat3 with dat_aax2 or dat_aax3 for other simulated datasets
	```
3. Run the following command to process all data files in the selected dataset. The results will be saved in the folders `EquiRep_test/EquiRep_error10` and `EquiRep_test/EquiRep_error20`.
	```
   	./exec.sh
   	```
### Evalultion for simulated data results
1. Navigate to the Evaluation Folder:
	```
	cd ../eval
	```
2. In `r_eval.sh`, specify the dataset to be evaluated:
	```
	true_dir=../data/simulated_data/dat3/$data_index
	# Replace dat3 with dat_aax2 or dat_aax3 for other datasets
	```
3. Run the following command to evaluate all results. The evaluation outputs will be saved in the same folder as the results.
	```
   	./r_eval.sh
   	```
4. Use the following command to compile all evaluation outputs into a summary sheet in the `EquiRep_test' folder:
	```
	python result_gather.py
	```

<!-- ## Running experiments on HOR data

## Running experiments on RCA data -->

# mTR

## Installation
To install mTR, visit the [official mTR repository](https://github.com/morisUtokyo/mTR) on GitHub.

## Running experiments on simulated data
1. Navigate to the mTR Testing Folder: 
	```
	cd mTR_test
	```
2. Change `run_mtr_simulated_data.sh` to set the location of mTR and select the dataset you'd like to use (options are dat3, dat_aax2, or dat_aax3):
	```
	dataset=dat3
	# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
	tool_dir=
	# Put the location of your installed mTR here
	```
3. Change `run_evaluate_edit.sh` to select the dataset you chose in Step 2:
	```
	true_dir=../data/simulated_data/dat3/$file
	# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
	```
4. Run the following command to process all data files in the selected dataset. The evaluation will be run as well. The results will be saved in the folders `data/simulated_data/{dataset name}/error_10/MTR_results` and `data/simulated_data/{dataset name}/error_20/MTR_results`.
	```
   	./run_all.sh
   	```
### Evalultion for simulated data results
1. Change `result_gather_mTR.py` to set the dataset you used:
	```
	base_dir = "../data/simulated_data/dat3"
	# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
	```
2. Use the following command to compile all evaluation results into a summary sheet in the `mTR_test' folder:
	```
	python result_gather_mTR.py
	```
<!-- 
## Running experiments on HOR data

## Running experiments on RCA data -->

# TRF

## Installation
To install TRF, visit the [official TRF repository](https://github.com/Benson-Genomics-Lab/TRF) on GitHub.

## Running experiments on simulated data
1. Navigate to the TRF Testing Folder: 
	```
	cd TRF_test
	```
2. Change `run_trf_simulated_data.sh` to set the location of TRF and select the dataset you'd like to use (options are dat3, dat_aax2, or dat_aax3):
	```
	dataset=dat3
	# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
	tool_dir=
	# Put the location of your installed TRF here
	```
3. Change `run_evaluate_edit.sh` to select the dataset you'd like to use (options are dat3, dat_aax2, or dat_aax3):
4. Run the following command to process all data files in the selected dataset. The evaluation will be run as well. The results will be saved in the folders `data/simulated_data/{dataset name}/error_10/TRF_results` and `data/simulated_data/{dataset name}/error_20/TRF_results`.
	```
   	./run_all.sh
   	```
### Evalultion for simulated data results
1. Change `result_gather_TRF.py` to set the dataset you used:
	```
	base_dir = "../data/simulated_data/dat3"
	# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
	```
2. Use the following command to compile all evaluation results into a summary sheet in the `TRF_test' folder:
	```
	python result_gather_TRF.py
	```

<!-- ## Running experiments on HOR data

## Running experiments on RCA data -->

# mreps

## Installation
To install mreps, visit the [official mreps page](https://mreps.univ-mlv.fr/howto.html).

## Running experiments on simulated data
1. Navigate to the mreps Testing Folder: 
	```
	cd mreps_test
	```
2. Change `run_mreps_simulated_data.sh` to set the location of mreps and select the dataset you'd like to use (options are dat3, dat_aax2, or dat_aax3):
	```
	dataset=dat3
	# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
	tool_dir=
	# Put the location of your installed mreps here
	```
3. Change `run_evaluate_edit.sh` to select the dataset you'd like to use (options are dat3, dat_aax2, or dat_aax3):
4. Run the following command to process all data files in the selected dataset. The evaluation will be run as well. The results will be saved in the folders `data/simulated_data/{dataset name}/error_10/mreps_results` and `data/simulated_data/{dataset name}/error_20/mreps_results`.
	```
   	./run_all.sh
   	```
### Evalultion for simulated data results
1. Change `result_gather_mreps.py` to set the dataset you used:
	```
	base_dir = "../data/simulated_data/dat3"
	# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
	```
2. Use the following command to compile all evaluation results into a summary sheet in the `mreps_test' folder:
	```
	python result_gather_mreps.py
	```

<!-- ## Running experiments on HOR data

## Running experiments on RCA data -->

# TideHunter

## Installation
To install TideHunter, visit the [official TideHunter repository](https://github.com/Xinglab/TideHunter) on GitHub.

## Running experiments on simulated data
1. Navigate to the tidehunter Testing Folder: 
	```
	cd tidehunter_test
	```
2. Change `run_mtr_simulated_data.sh` to set the location of tidehunter and select the dataset you'd like to use (options are dat3, dat_aax2, or dat_aax3):
	```
	dataset=dat3
	# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
	tool_dir=
	# Put the location of your installed Tidehunter/bin here
	```
3. Change `run_evaluate_edit.sh` to select the dataset you'd like to use (options are dat3, dat_aax2, or dat_aax3):
4. Run the following command to process all data files in the selected dataset. The evaluation will be run as well. The results will be saved in the folders `data/simulated_data/{dataset name}/error_10/TH_results` and `data/simulated_data/{dataset name}/error_20/TH_results`.
	```
   	./run_all.sh
   	```
### Evalultion for simulated data results
1. Change `result_gather_tidehunter.py` to set the dataset you used:
	```
	base_dir = "../data/simulated_data/dat3"
	# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
	```
2. Use the following command to compile all evaluation results into a summary sheet in the `tidehunter_test' folder:
	```
	python result_gather_tidehunter.py
	```

<!-- ## Running experiments on HOR data

## Running experiments on RCA data -->

