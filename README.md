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
	```bash
	cd EquiRep_test
	```
2. Open exec.sh to select the dataset you'd like to use (options are dat3, dat_aax2, or dat_aax3):
	```
	input_dir_prefix=../data/simulated_data/dat3
	# Replace dat3 with dat_aax2 or dat_aax3 for other simulated datasets
	```
3. Execute the following command to process all data files in the selected dataset:
	```bash
   	./exec.sh
   	```
### Evalultion for simulated data results
1. Navigate to the Evaluation Folder:
	```bash
	cd ../eval
	```
2. In `r_eval.sh`, specify the dataset to be evaluated:
	```
	true_dir=../data/simulated_data/dat3/$data_index
	# Replace dat3 with dat_aax2 or dat_aax3 for other datasets
	```
3. Run the evaluation script:
	```bash
   	./r_eval.sh
   	```
4. Use the following command to compile all evaluation results into a summary sheet in the `EquiRep_test' folder:
	```bash
	python result_gather.py
	```

## Running experiments on HOR data

## Running experiments on RCA data

# mTR

## Installation

Use the mTR repo for installation https://github.com/morisUtokyo/mTR

## Running experiments on simulated data

To reproduce the MTR results in the paper. First install MTR. In the `MTR_scripts`, change the `run_mtr_simulated_data.sh`.
```
tool_dir=/data/tkz5115/repeat_project/tools/mTR
input_dir=/data/tkz5115/repeat_project/data/dat3/$file
output_dir=/data/tkz5115/repeat_project/data/dat3/$file/MTR_results
```
Then use `MTR_scripts/run_all.sh` to run MTR on all simulated data and get a evalution of the results.
## Running experiments on HOR data

## Running experiments on RCA data

# TRF
## Running experiments on simulated data
To reproduce the TRF results in the paper. First install TRF. In the `TRF_scripts`, change the `run_trf_simulated_data.sh`.
```
tool_dir=/data/tkz5115/repeat_project/tools/TRF
input_dir=/data/tkz5115/repeat_project/data/dat3/$file
output_dir=/data/tkz5115/repeat_project/data/dat3/$file/TRF_results
```
Then use `TRF_scripts/run_all.sh` to run MTR on all simulated data and get a evalution of the results.
## Running experiments on HOR data

## Running experiments on RCA data

# mreps
## Running experiments on simulated data
To reproduce the mreps results in the paper. First install mreps. In the `mreps_scripts`, change the `run_mreps_simulated_data.sh`.
```
tool_dir=/data/tkz5115/repeat_project/tools/mreps
input_dir=/data/tkz5115/repeat_project/data/dat3/$file
output_dir=/data/tkz5115/repeat_project/data/dat3/$file/mreps_results
```
Then use `mreps_scripts/run_all.sh` to run mreps on all simulated data and get a evalution of the results.
## Running experiments on HOR data

## Running experiments on RCA data

# tideHunter
## Running experiments on simulated data
To reproduce the tideHunter results in the paper. First install tideHunter. In the `tidehunter_scripts`, change the `run_th_simulated_data.sh`.
```
tool_dir=/data/tkz5115/repeat_project/tools/TideHunter-v1.5.5/bin
input_dir=/data/tkz5115/repeat_project/data/dat3/$file
output_dir=/data/tkz5115/repeat_project/data/dat3/$file/TH_results
```
Then use `tidehunter_scripts/run_all.sh` to run MTR on all simulated data and get a evalution of the results.
## Running experiments on HOR data

## Running experiments on RCA data

