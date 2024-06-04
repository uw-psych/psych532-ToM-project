## Description of each script: 


## Setting up conda environment:
You will first need to install [anaconda](https://docs.anaconda.com/free/anaconda/install/) on your machine. Open the terminal and type each line of code (hit enter after each line). 

`conda create -n ENVIRONMENTNAME python=3.8 --file=enviornment.yaml`

This will create a new environment (line 1 below)— here the environment is called ENVIRONMENTNAME, but you should change it to something more suitable for your project. You can create many different environments if need be. The reason to create an environment is to keep code installs and dependencies stable and separate from each other.

Once the environment is created, you need to activate it to actually work inside it. 

`conda activate ENVIRONMENTNAME `

Once activated, you can install any additional packages, but all packages for our analyses will already be installed from `environment.yaml`. 

`conda install -c conda-forge [packagename]` 

You can see which packages are installed by runnning `conda list`. 

You might want to install install the IPython kernel which lets you use jupyter notebooks.

`ipython kernel install --user --name=ENVIRONMENTNAME `

If you've isntalled any new new packages, you can save those changes into the `environment.yml`. 

`how to yml command` 

References: 
[Master the basics of Conda environments](https://www.youtube.com/watch?v=1VVCd0eSkYc)


