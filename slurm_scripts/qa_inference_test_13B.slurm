#!/bin/bash -l

#SBATCH --job-name=QA_Inference_13B
#SBATCH --output=QA_Inference_13B.out
#SBATCH --error=QA_Inference_13B.err
#SBATCH --partition=pophealth
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --mem=100G
#SBATCH --time=12:00:00
#SBATCH --gres=gpu:a100:2
#SBATCH --export=ALL
#SBATCH --mail-type=ALL
#SBATCH --mail-user=coen.arrow@research.uwa.edu.au
printf "Starting job $SLURM_JOB_NAME, ID $SLURM_JOB_ID\n\n" 

 # Load the relevant modules
module load cuda/11.6
module load Anaconda3/2023.09

# leave in, it lists the environment loaded by the modules
module list

# Set project directory
PROJECT_DIR=/group/pgh004/carrow/repo/MedLLM/PMC-LLaMA
cd $PROJECT_DIR
# load the conda environment
conda activate ./env
SCRIPT=qa_inference_test.py

printf " \n Started at $(date) \n \n " 
start_time=$(date +%s)

# Run the three python scripts below in parallel
python ./${SCRIPT} --model-name-or-path axiong/PMC_LLaMA_13B --write-dir results/13B


end_time=$(date +%s)
runtime=$((end_time-start_time))
printf " \n Finished at $(date) \n " 
printf " \n Total runtime: $runtime seconds \n " 