

# Create and Save experimental design:
source("uc1-derived-R-json/R/r_functions.R")
experimental_design = create_experimental_design(a_vector = 1:100, b_vector = 1:3)

writeLines(experimental_design$json_inputs, "uc1-derived-R-json/data/experimental_design.txt")
