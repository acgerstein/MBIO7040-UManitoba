#19.04.11 R Workshop Day 2

### ggplot & stats

# Load libraries
library(tidyverse)
library(here)

# download the data from the internet
# Only need to do this once!
#download.file("http://home.cc.umanitoba.ca/~gersteia/MBIO7040/Calb_resistance.csv",
#              here("data_in", "Calb_resistance.csv"))

# load the data

# look at the data

# rename the two numerical variables

# download a new package "skimr"
install.packages("skimr")
library(skimr)

# look at the summary information for the two numerical variables of interest

# explore disk diffusion resistance

# double check NAs

# multiple ways to do the same thing
# aes specified in "ggplot"


# play with plot aesthetics
ggplot(data = , mapping = ) +
  # plot the histograms, change binwidth to 1
  geom_histogram() +
  # change the theme
  theme_bw() +
  # change the x and y labels
  labs() +
  # remove the grid lines
  theme()

# test to see if disk resistance is normally distributed - no it is not

# adding information about categorical variables to our figure
# play with plot aesthetics
# add fill = type to plot the different strain types with different colours

# plot three different histograms in different panels, one for each strain type

# Create a figure with two panels, one for each gender, that colours the strain types differently. Add a title to the figure. Play with bin or bindwidth.

# Create a figure that has two panels, one for each gender

# Create a figure that has two panels, one for each gender, that colours the strain types differently

# bonus points:
# use different colours than the default
# change the facet labels from "f" and "m" to "female" and "male"

# compare disk resistance between men and women
# H0: no difference
# HA: there is a difference
wilcox.test()

# test whether the place strains were isolated from (type) is associated with disk resistance (disk)
anova_test <- aov()

# install the broom package
#install.packages("broom")
library(tidyverse)
library(broom)

# use the broom function tidy to look at the output from the anova test
anova_test_tidy <- tidy()

# why is the tidy function underlining some of the numbers?
TukeyHSD()

# Use a single anova that tests for the influence of both categorical variables on disk resistance at the same time
full_anova_test <- aov()

# we want to tell the story of strain type on disk resistance
# use a box plot: type is on the x axis, disk resistance on the y. Save it to the object p

# make the plot p nicer: change the labels, reverse the y axis scale and annotate with the output of the tukey test

# I don't actually like boxplots that much. Let's change it to a violin plot instead. Change geom_boxplot to geom_violin

# add back the pretty things

# Look at the distribution of MIC

#Histogram

# Use a bar plot because we have counts data (the ONLY time to use a bar plot)

# put the origin at the bottom

# Now we want to add strain type information here
# I need to create a new tibble, that calculates how many strains fall into each of the three types for each of the MIC groups.

#Plot the counts in a bar plot where the number of strains of each type is plotted beside each other at each MIC level

# Conduct a statistical test to determine whether type or gender (or their interaction) has a significant effect on MIC.

# Ask whether there is a relationship between the two measurements of resistance : disk and MIC

# Let's add a line of fit to this

# test whether resistance from MIC is correlated with  resistance from disk diffusion

# Programmatic figure save

