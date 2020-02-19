#!/bin/bash

#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --partition=gpuv100
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=12:00:00

#SBATCH --job-name=ENAS_Job
#SBATCH --output=output.log
#SBATCH --mail-type=ALL
#SBATCH --mail-user=v_bros02@uni-muenster.de

# load modules with available GPU support (this is an example, modify to your needs!)
module load GCCcore
module load Python/2.7.15
module load fosscuda

srun bash scripts/cifar10_micro_search.sh 3 2 /scratch/tmp/v_bros02/enas /scratch/tmp/v_bros02/enas_data