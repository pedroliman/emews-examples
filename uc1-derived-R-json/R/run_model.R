
library(rjson)
# Get model inputs
model_inputs = commandArgs(trailingOnly = T)

# Source model:
source(file = "./uc1-derived-R-json/R/r_functions.R")

# run model:
results = model_function(model_inputs)

# Continue tomorrow.
