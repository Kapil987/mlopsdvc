python3 -m venv myvenv
pip install dvc dvc_s3
conda create -n dvcdemo python=3.12 -y
source .venv/bin/activate

download dataset from https://www.kaggle.com/datasets/yasserh/wine-quality-dataset?resource=download

#### Amazon Q
curl --proto '=https' --tlsv1.2 -sSf "https://desktop-release.q.us-east-1.amazonaws.com/latest/q-x86_64-linux.zip" -o q.zip
echo 'export PATH="$HOME/q/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

log in via your builder id and then type below command
Open this URL: https://view.awsapps.com/start/#/device?user_code=CWQH-BMTV
Device authorized
Logged in successfully

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

dvc remote add s3://bucketname
dvc remote list
dvc remote default REMOTE-BACKEND-NAME

dvc add DATASET.csv
dvc status
git add .gitignore wine_ds.csv.dvc
dvc push

- edit the data.csv
- dvc status
- dvc add data.csv
- git add data.csv.dvc
- git commit -m "some comments"

Here is theworkflow to switch between your 3 versions:

### 1. Identify the Version (Git Log)

First, find the commit hash for the version you want to see.

```bash
git log --oneline wine_ds.csv.dvc

```

*Let's assume your hashes are `43cd6a1` (v1), `3220f26` (v2), and a new one for v3.*

---

### 2. Switch to the Target Version

You have two ways to do this:

#### A. The "Temporary Peek" (Recommended)

If you just want to see the old data without moving your whole project back in time:

```bash
# 1. Get the old .dvc file from Git history
git checkout 43cd6a1 wine_ds.csv.dvc

# 2. Tell DVC to sync the .csv file to match that old pointer
dvc checkout

```

#### B. The "Full Rollback"

If you want to move your entire repository (code and data) back to that point:

```bash
git checkout 43cd6a1
dvc checkout

```

---

### 3. Verify and Inspect

Now that the file has been swapped, verify it is the one you expected:

```bash
# Check the first few lines
head -n 5 wine_ds.csv

# Check the DVC status (it should show no changes)
dvc status

```

---

### 4. How to Return to the Latest Version

Once you are done viewing the old data, you should move back to the "present" so you don't accidentally start working on old files.

```bash
# 1. Bring the latest metadata back
git checkout main wine_ds.csv.dvc

# 2. Sync the data back to the latest version
dvc checkout

```

example
myvenv) ubuntu@ip-172-31-26-84:~/mlopsdvc$ git log --oneline
ea4db53 (HEAD -> main) 11 line duplicated1
bb835ba initial wine data added
745e29a first commit without data
(myvenv) ubuntu@ip-172-31-26-84:~/mlopsdvc$ git checkout bb835ba wine_ds.csv.dvc
Updated 1 path from 60ca25c
(myvenv) ubuntu@ip-172-31-26-84:~/mlopsdvc$ dvc checkout
Building workspace index                                                              |1.00 [00:00, 39.7entry/s]
Comparing indexes                                                                    |2.00 [00:00, 2.00kentry/s]
Applying changes                                                                      |1.00 [00:00,   165file/s]
M       wine_ds.csv
(myvenv) ubuntu@ip-172-31-26-84:~/mlopsdvc$ 

#### MLFLOW
- pip install mlflow
- powershell -c "irm https://astral.sh/uv/install.ps1 | iex"

#### Kuberntes
https://community-charts.github.io/docs/charts/mlflow/usage
kubectl --namespace default port-forward --address 0.0.0.0 $POD_NAME 8080:$CONTAINER_PORT
kubectl --namespace default port-forward --address 0.0.0.0 deployment/your-deployment-name 8080:$CONTAINER_PORT
sudo apt install kubectx #installs both kubectx and kubens

#### Postgres
-- 1. Create the user
CREATE USER mlflow_user WITH PASSWORD 'mlflow';

-- 2. Create the database
CREATE DATABASE mlflow1;

-- 3. Connect to the new database (CRITICAL STEP)
\c mlflow1

-- 4. Grant full ownership of the database to the user
GRANT ALL PRIVILEGES ON DATABASE mlflow1 TO mlflow_user;

-- 5. Grant permission to create tables in the public schema (Required for Postgres 15+)
GRANT USAGE, CREATE ON SCHEMA public TO mlflow_user;

-- 6. Ensure the user can access future tables created during migrations
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO mlflow_user;

