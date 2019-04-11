###03-R_Start

### Creating objects in R

# What are the values stored in each object in the following (do this in your head)?
# mass <- 50              # mass?
# age  <- 122             # age?
# mass <- mass * 2.0      # mass?
# age  <- age - 22        # age?
# mass_index <- mass/age  # mass_index?

### Vectors and data types
# Weâ€™ve seen that atomic vectors can be of type character, numeric, integer, and
# logical. But what happens if we try to mix these types in a single
# vector?

# What will happen in each of these examples? (hint: use `class()` to
# check the data type of your object)
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

# Why do you think it happens?
#How many values in `combined_logical` are "TRUE" (as a character) in the following example:
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

### Conditional Subsetting
#Can you figure out why "five" > "four" returns TRUE?

### Missing Data
#1. Using this vector of heights in inches, create a new vector, `heights_no_na`, with the NAs removed.
heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

#2. Use the function median() to calculate the median of the heights vector.

#3. Use R to figure out how many people in the set are taller than 67 inches.


###04-Starting with Data

### Download E coli data
library(here)
library(tidyverse)
download.file("https://raw.githubusercontent.com/datacarpentry/R-genomics/gh-pages/data/Ecoli_metadata.csv",
              here("data_in", "Ecoli_citrate.csv"))
here("data_in", "Ecoli_citrate")
Ecoli_citrate <- read_csv(here("data_in", "Ecoli_citrate.csv"))

###05-Manipulating data with dplyr

Ecoli_citplus <- Ecoli_citrate %>%
  select(sample, generation, clade, cit) %>%
  filter(cit == "plus")

Ecoli_citrate %>%
  mutate(genome_bp = genome_size  * 1e6) %>%
  filter(!is.na(clade))

Ecoli_citrate %>%
  filter(!generation < 30000)

Ecoli_citrate %>%
  group_by(cit) %>%
  summarize(n())

Ecoli_citrate %>%
  group_by(cit) %>%
  summarize(mean_size = mean(genome_size, na.rm = TRUE))

Ecoli_citrate %>%
  group_by(cit, clade) %>%
  summarize(mean_size = mean(genome_size, na.rm = TRUE))

Ecoli_citrate %>%
  group_by(cit, clade) %>%
  summarize(mean_size = mean(genome_size, na.rm= TRUE), min_generation = min(generation))


# Create a tibble that has
# filter: removed the rows with uknown clade
# group by: each unique clade
# summarise: find the mean genome size of each unique clade
# mutate: find the rank of mean genome size of each unique clade


unique(Ecoli_citrate$generation)

### Pipes
#Using pipes, subset `Ecoli_citrate` to include rows where the clade is â€˜Cit+â€™ and keep only the columns `sample`, `cit`, and `genome_size`
#How many rows are in that tibble?




### Mutate
#Create a tibble containing each unique clade (removing the samples with unknown clades) and the rank of it's mean genome size. (note that #ranking genome size will not sort the table; the row order will be unchanged. You can use the `arrange()` function to sort the table).
# There are several functions for ranking observations, which handle tied values differently. For this exercise it doesnâ€™t matter which #function you choose. Use the help options to find a ranking function.

# Hint: think about how many commands are required and what their order should be to produce this tibble!

### BONUS
# Challenge:
#  There are a few mistakes in this hand-crafted `data.frame`,
#  can you spot and fix them? Don't hesitate to experiment!
animal_data <- data.frame(
  animal = c(dog, cat, sea cucumber, sea urchin),
  feel = c("furry", "squishy", "spiny"),
  weight = c(45, 8 1.1, 0.8)
)

# Challenge:
#   Can you predict the class for each of the columns in the following example?
#   Check your guesses using `str(country_climate)`:
#   * Are they what you expected? Why? why not?
#   * What would have been different if we had added `stringsAsFactors = FALSE`
#     when we created this data frame?
#   * What would you need to change to ensure that each column had the
#     accurate data type?
country_climate <- tibble(country = c("Canada", "Panama", "South Africa", "Australia"),
                          climate = c("cold", "hot", "temperate", "hot/temperate"),
                          temperature = c(10, 30, 18, "15"),
                          northern_hemisphere = c(TRUE, TRUE, FALSE, "FALSE"),
                          has_kangaroo = c(FALSE, FALSE, FALSE, 1))
