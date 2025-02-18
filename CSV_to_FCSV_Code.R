library(geomorph)
library(SlicerMorphR)


setwd("C:/Users/HARDGRAVE/Downloads/Jones_T1/Jones_T1")
files=dir(patt='csv')

T1.samples=gsub(".csv", '', fixed=T, files)


# Initialize an array to store the landmark data
T1.LMs <- array(dim = c(44, 3, length(files)))


# Read each CSV file and store the data in the array
for (i in 1:length(files)) {
  data <- as.matrix(read.csv(files[i], header = TRUE))[, 2:4]  # Skip the first column
  print(dim(data))  # Print the dimensions of the current file
  if (all(dim(data) == c(44, 3))) {
    T1.LMs[,,i] <- data
  } else {
    stop(paste("File", files[i], "does not have the correct dimensions"))
  }
}

# Assign dimension names to the array
dimnames(T1.LMs) <- list(paste0("LM_", 1:44), c("x", "y", "z"), T1.samples)

# Check the dimensions of the 3D array
dim(T1.LMs)

view(T1.LMs)

# Write individual .fcsv files for each specimen
for (i in 1:length(files)) {
  specimen_data <- T1.LMs[,,i]
  specimen_name <- T1.samples[i]
  output_file <- paste0(specimen_name, ".fcsv")
  write.markups.fcsv(specimen_data, output_file)
}

# Check the output files
list.files(pattern = "*.fcsv")