python3 -m venv myvenv
pip install dvc dvc_s3
conda create -n dvcdemo python=3.12 -y
source .venv/bin/activate

download dataset from https://www.kaggle.com/datasets/yasserh/wine-quality-dataset?resource=download

#### WINDOWS
conda init bash
then 
re-open git bash
source ~/.bash_profile # .bashrc depending upon your configuration

#### Git and DVC
git init
dvc init
git branch -m main
git remote add origin YOUR_REPO

dvc add DATASET.csv
dvc status

dvc remote add s3://bucketname
dvc remote list
dvc remote default ml1
