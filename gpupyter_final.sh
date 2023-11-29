#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --job-name=CheckEnvironment
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=00:05:00
#SBATCH --output=slurm_output_%A.out

module purge
module load 2022
module load Anaconda3/2022.05

PORT=`shuf -i 5000-5999 -n 1`
LOGIN_HOST=int4-pub.snellius.surf.nl
BATCH_HOST=$(hostname)

echo "Selected port is: " $PORT
echo
echo "To connect to the notebook type the following command from your local terminal:"
echo "ssh -J ${USER}@${LOGIN_HOST} ${USER}@${BATCH_HOST} -L ${PORT}:localhost:${PORT}"
echo
echo "After connection is established in your local browser go to the address:"
echo "http://localhost:${PORT}"

~/miniconda3/envs/torch/bin/jupyter notebook --no-browser --port $PORT
