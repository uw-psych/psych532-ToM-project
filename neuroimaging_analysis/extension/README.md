## Data provenance: 
Preprocessed data was downloaded from OpenNeuro using `datalad`, and parcellated into ROIs according to Schaefer-100 (see `001_extract_timeseries.py`. Preprocessing was done by OpenNeuro using fmriprep. 

Data was then processed into functional connectivity matrices using [custom scripts](ttps://github.com/mckenziephagen/functional-connectivity-comparison), which were then flattened from 100x100 matrices to 10,000 arrays and organized into fc_vals.csv. 

## Description of each script: 
 `001_extract_timeseries.py` takes a path to a datalad subject and creates a parcellated timeseries from the preprocessed data. 

 [`calc_fc.py`](https://github.com/mckenziephagen/functional-connectivity-comparison/blob/main/01-Processing/calc_fc.py) takes the parcellated timeseries and calculates a functional correlation matrix. 

[`organize_results.py`](https://github.com/mckenziephagen/functional-connectivity-comparison/blob/main/01-Processing/organize_results.py) takes the output of calc_fc and aggregates all of the participants into `fc_vals.csv`.

`002_classication_model.py` uses `sklearn` to build a regularized logistic regression classifier. 

`run_serially.sh` runs `002_classication_model.py` in a for loop 1000 times for bootstrapping. 

`003_visualize_results.py` takes all of the results, aggregates them, and creates a boxplot (not used in final writeup), a histogram, and the confusion matrix. 

 
## Setting up conda environment:
You will first need to install [anaconda](https://docs.anaconda.com/free/anaconda/install/) on your machine. Open the terminal and type each line of code (hit enter after each line). 

`conda create -n ENVIRONMENTNAME python=3.8 --file=spec-file.txt`

This will create a new environment. Here the environment is called ENVIRONMENTNAME, but you should change it to something more suitable for your project. You can create many different environments if need be. The reason to create an environment is to keep code installs and dependencies stable and separate from each other.

Once the environment is created, you need to activate it to actually work inside it. 

`conda activate ENVIRONMENTNAME `

Once activated, you can install any additional packages, but all packages for our analyses will already be installed from `environment.yaml`. 

`conda install -c conda-forge [packagename]` 

You can see which packages are installed by runnning `conda list`. 

You might want to install install the IPython kernel which lets you use jupyter notebooks.

`ipython kernel install --user --name=ENVIRONMENTNAME `

If you've isntalled any new new packages, you can save those changes into the `spec-file.txt`. 

`conda list --explicit > spec-file.txt` 

References: 
[Master the basics of Conda environments](https://www.youtube.com/watch?v=1VVCd0eSkYc)


