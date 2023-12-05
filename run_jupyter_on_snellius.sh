#!/bin/bash

# Serve a jupyter lab environment from a compute node on Snellius
# usage: sbatch run_jupyter_on_compute_node.sh

# SLURM settings
#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=CheckEnvironment
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=00:05:00
#SBATCH --output=slurm_output_%A.out

# Use an appropriate conda environment
. ~/miniconda3/etc/profile.d/conda.sh
conda activate dl2023

# Some security: stop script on error and undefined variables
set -euo pipefail

# Specify (random) port to serve the notebook
port=8123
host=$(hostname -s)

# Print command to create ssh tunnel in log file
echo -e "

Command to create ssh tunnel (run from another terminal session on your local machine):
ssh -L ${port}:${host}:${port} $(whoami)@snellius.surf.nl
Below, jupyter will print a number of addresses at which the notebook is served.
Due to the way the tunnel is set up, only the latter option will work.
It's the one that looks like
http://127.0.0.1:${port}/?token=<long_access_token_very_important_to_copy_as_well>
Copy this address in your local browser and you're good to go

Starting notebooks server
**************************************************
"

# Start the jupyter lab session

jupyter lab --no-browser --port ${port} --ip=${host}
