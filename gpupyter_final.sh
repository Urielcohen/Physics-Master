#!/bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=12:00:00
#SBATCH -p gpu
#SBATCH --gpus-per-node=1

#     ^^^ REPLACE WITH PARTITION WITH IDLE NODES! (use gpu_titanrtx_shared (1gpu) or gpu_titanrtx_short (short time))


# Make sure the jupyter command is available, either by loading the appropriate modules, sourcing your own virtual environment, etc.
#module load 2021
#module load IPython/7.25.0-GCCcore-10.3.0# Choose random port and print instructions to connect

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
