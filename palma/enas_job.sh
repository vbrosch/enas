#!/bin/bash

#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --partition=gputitanxp
#SBATCH --mem=32G
#SBATCH --gres=gpu:1
#SBATCH --time=12:00:00

#SBATCH --job-name=ENAS_Job
#SBATCH --output=output.log
#SBATCH --mail-type=ALL
#SBATCH --mail-user=v_bros02@uni-muenster.de

# load modules with available GPU support (this is an example, modify to your needs!)

module load GCC/8.2.0-2.31.1
module load CUDA/10.1.105
module load cuDNN/7.6.4.38

srun bash scripts/cifar10_micro_search.sh /scratch/tmp/v_bros02/enas /scratch/tmp/v_bros02/enas_data
