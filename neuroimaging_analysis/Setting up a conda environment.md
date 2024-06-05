**How to set up a basic python environment**
----

You will first need to install [anaconda](https://www.anaconda.com) on your machine.
Open the terminal and type each line of code (hit enter after each line).
This will create a new environment (line 1 below)— here the environment is called ```ENVIRONMENTNAME```, but you should change it to something more suitable for your project. You can create many different environments if need be. The reason to create an environment is to keep code installs and dependencies stable and separate from each other.

Once the environment is created, you need to activate it (line 2) to actually work inside it. Once activated, you can install basic python modules (line 3). The 4th and 5th lines install the IPython kernel which lets you use jupyter notebooks. Finally, ```pip freeze``` is a useful command that lets you see what modules you have installed. You should run it after making any changes to the environment. The ```requirements.txt``` file can be used to re-create the environment if you ever move to a new computer or share your code with someone else.

```py
conda create -n ENVIRONMENTNAME python=3.8  

conda activate ENVIRONMENTNAME  

conda install numpy scipy matplotlib jupyter seaborn pandas scikit-learn scikit-image h5py ipython

conda install ipykernel

ipython kernel install --user --name=ENVIRONMENTNAME  

pip freeze > requirements.txt

```
References
-----
[Master the basics of Conda environments in Python](https://www.youtube.com/watch?v=1VVCd0eSkYc)
