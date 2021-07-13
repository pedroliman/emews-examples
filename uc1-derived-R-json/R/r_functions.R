

# Test List of functions to sourc from the R script:

library(dplyr)
library(rjson)
# create the experimental design:

create_model_inputs = function(a, b) {

  model_inputs = list(a = a, b = b,
                      n = 10,
                      # This could be relative to the project path.
                      model_path = "/Users/plima/Documents/dev/crc/emews-examples/uc1-derived-R-json/R/r_functions.R")

  rjson::toJSON(model_inputs, indent = 0)
}

# Create model as json:

# This can be done in a better way

create_experimental_design = function(a_vector, b_vector){
  experimental_design = expand.grid(a_vector, b_vector)
  names(experimental_design) = c("a", "b")

  experimental_design = experimental_design %>%
    dplyr::mutate(json_inputs = NA,
                  experiment_id = dplyr::row_number())

  experimental_design$json_inputs = NA

  # Could use a map or apply fn, but this is not computationally intensive:
  # This part can also be better generalized for any parameters
  for(i in 1:nrow(experimental_design)) {
    experimental_design[i,"json_inputs"] = create_model_inputs(a = experimental_design$a[i], b = experimental_design$b[i])
  }
  # but the point is that at the end we get this:
  experimental_design
}

model_function = function(json_inputs){

  # Converts the json back to the R object
  model_inputs = rjson::fromJSON(json_inputs)

  # runs some calculation
  mult = model_inputs$a * model_inputs$b
  sum = model_inputs$a + model_inputs$b

  # creates a list with results (don't duplicate inputs!)
  result = list(mult = mult, sum = sum)

  # Returns json or writes json results.
  return(rjson::toJSON(result, indent = 0))

}


