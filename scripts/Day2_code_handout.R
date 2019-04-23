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
Calb_R <- read_csv(here("data_in", "Calb_resistance.csv"))
Calb_R

# look at the data
glimpse(Calb_R)

# rename the two numerical variables
Calb_R <- Calb_R %>%
  rename(MIC = "MIC (ug/mL)", disk = "disk (mm)")
glimpse(Calb_R)

# download a new package "skimr
install.packages("skimr")
library(skimr)

# look at the summary information for the two numerical variables of interest
skim(Calb_R)

# explore disk diffusion resistance
ggplot(data = Calb_R, mapping = aes(disk)) +
  geom_histogram(binwidth = 1, na.rm=TRUE)

# double check NAs
Calb_R %>%
  filter(is.na(disk))

# multiple ways to do the same thing
# aes specified in "ggplot"
ggplot(data = Calb_R, mapping = aes(disk)) +
  geom_histogram(binwidth = 1, na.rm=TRUE)
#aes specified in "geom"
ggplot(data = Calb_R) +
  geom_histogram(mapping = aes(disk), binwidth = 1, na.rm=TRUE)

# play with plot aesthetics
ggplot(data = Calb_R, mapping = aes(disk)) +
  # plot the histograms, change binwidth to 1
  geom_histogram(binwidth = 1, na.rm=TRUE) +
  # change the theme
  theme_bw() +
  # change the x and y labels
  labs(x = "disk diffusion zone of inhibition (mm)", y = "number of strains") +
  # remove the grid lines
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

# test to see if disk resistance is normally distributed - no it is not
shapiro.test(Calb_R$disk)

# adding information about categorical variables to our figure
# play with plot aesthetics
# add fill = type to plot the different strain types with different colours
ggplot(data = Calb_R, mapping = aes(disk, fill = type)) +
  geom_histogram(binwidth = 1, na.rm=TRUE) +
  theme_bw() +
  labs(x = "disk diffusion zone of inhibition (mm)", y = "number of strains") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

# plot three different histograms in different panels, one for each strain type
ggplot(data = Calb_R, mapping = aes(disk)) +
  geom_histogram(binwidth = 1, na.rm=TRUE) +
  theme_bw() +
  labs(x = "disk diffusion zone of inhibition (mm)", y = "number of strains") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  facet_wrap(~type)

# Create a figure with two panels, one for each gender, that colours the strain types differently. Add a title to the figure. Play with bin or bindwidth.

# Create a figure that has two panels, one for each gender
ggplot() +
  geom_histogram() +
  facet_wrap()

# Create a figure that has two panels, one for each gender, that colours the strain types differently
ggplot() +     # use fill to colour strain types diffently
  geom_histogram() +
  facet_wrap()

# bonus points:
# use different colours than the default
# change the facet labels from "f" and "m" to "female" and "male"

# compare disk resistance between men and women
# H0: no difference
# HA: there is a difference
wilcox.test(disk ~ gender, data = Calb_R)
# W = 30727, p-value = 0.928

# test whether the place strains were isolated from (type) is associated with disk resistance (disk)
anova_test <- aov(disk ~ type, data = Calb_R)
summary(anova_test)

# install the broom package
#install.packages("broom")
library(tidyverse)
library(broom)

# use the broom function tidy to look at the output from the anova test
anova_test_tidy <- tidy(anova_test)
anova_test_tidy$p.value[1]

# why is the tidy function underlining some of the numbers?
TukeyHSD(anova_test)

# Use a single anova that tests for the influence of both categorical variables on disk resistance at the same time
full_anova_test <- aov(disk ~ type*gender, data = Calb_R)
tidy(full_anova_test)

# we want to tell the story of strain type on disk resistance
# use a box plot: type is on the x axis, disk resistance on the y. Save it to the object p
p <- ggplot(data = Calb_R, mapping = aes(x = type, y = disk)) +
  geom_boxplot(na.rm=TRUE) +
  theme_bw()

# make the plot p nicer: change the labels, reverse the y axis scale and annotate with the output of the tukey test
p +
  labs(x = "site of strain isolation", y = "disk diffusion zone of inhibition (mm)") +
  scale_y_reverse(limits= c(50, 0)) +
  annotate("text", x = c(1, 2, 3), y = 0, label = c("a", "b", "b"))

# I don't actually like boxplots that much. Let's change it to a violin plot instead. Change geom_boxplot to geom_violin
pV <- ggplot(data = Calb_R, mapping = aes(x = type, y = disk)) +
  geom_violin(na.rm=TRUE) +
  theme_bw()

# add back the pretty things
pV +
  labs(x = "site of strain isolation", y = "disk diffusion zone of inhibition (mm)") +
  scale_y_reverse(limits= c(50, 0)) +
  annotate("text", x = c(1, 2, 3), y = 0, label = c("a", "b", "b"))

pV +
  stat_summary(fun.y = mean, geom = "point", shape = 23, size = 3, fill = "red") +
  labs(x = "site of strain isolation", y = "disk diffusion zone of inhibition (mm)") +
  scale_y_reverse(limits= c(50, 0)) +
  annotate("text", x = c(1, 2, 3), y = 0, label = c("a", "b", "b"))

# Look at the distribution of MIC

#Histogram
pM <- ggplot(data = Calb_R, mapping = aes(x = MIC)) +
  geom_histogram(na.rm=TRUE) +
  theme_bw()

pM +
  scale_x_continuous(trans = "log2")

# Use a bar plot because we have counts data (the ONLY time to use a bar plot)
pB <- ggplot(data = Calb_R, mapping = aes(x = MIC)) +
  geom_bar(na.rm=TRUE) +
  theme_bw() +
  scale_x_continuous(trans = "log2") +
  labs(x = expression(MIC[50]), y = "Number of strains")

pB

# put the origin at the bottom
pB +
  scale_x_continuous(expand = c(0, 0), trans = "log2") +
  scale_y_continuous(expand = c(0, 0))

# Now we want to add strain type information here
# I need to create a new tibble, that calculates how many strains fall into each of the three types for each of the MIC groups.
Calb_R_counts <- Calb_R %>%
  group_by(type, MIC) %>%
  summarize(num_strains = n())

#Plot the counts in a bar plot where the number of strains of each type is plotted beside each other at each MIC level

pCount <- ggplot(Calb_R_counts, mapping = aes(x = MIC, y = num_strains, fill = type)) +
  geom_bar(stat = "identity", na.rm =TRUE, width = 0.75) +
  scale_x_continuous(trans = "log2") +
  labs(x = expression(MIC[50]), y = "Number of strains")

pCount

pCount_beside <- ggplot(Calb_R_counts, mapping = aes(x = MIC, y = num_strains, fill = type)) +
  geom_bar(stat = "identity", na.rm =TRUE, width = 0.75,
           position = position_dodge(preserve = "single")) +
  scale_x_continuous(trans = "log2") +
  labs(x = expression(MIC[50]), y = "Number of strains")
pCount_beside

# Conduct a statistical test to determine whether type or gender (or their interaction) has a significant effect on MIC.

# Ask whether there is a relationship between the two measurements of resistance : disk and MIC

gP <- ggplot(Calb_R, aes(x = MIC, y = disk)) +
  geom_point(na.rm = TRUE) +
  scale_x_continuous(trans = "log2") +
  labs(x = expression(MIC[50]), y = "Resistance from disk diffusion (mm)") +
  scale_y_reverse(limits = c(50, 0)) +
  theme_bw()

gP

# Let's add a line of fit to this
gP +
  geom_smooth(method = "lm", na.rm = TRUE)

gP_jitter <- ggplot(Calb_R, aes(x = MIC, y = disk)) +
  geom_jitter(color = "tomato", width = 0.2) +
  scale_x_continuous(trans = "log2") +
  labs(x = expression(MIC[50]), y = "Resistance from disk diffusion (mm)") +
  scale_y_reverse(limits = c(50, 0)) +
  theme_bw() +
  geom_smooth(method = "lm", na.rm = TRUE)

gP_jitter_alpha <- ggplot(Calb_R, aes(x = MIC, y = disk)) +
  geom_jitter(color = "tomato", width = 0.2, alpha = 0.5) +
  scale_x_continuous(trans = "log2") +
  labs(x = expression(MIC[50]), y = "Resistance from disk diffusion (mm)") +
  scale_y_reverse(limits = c(50, 0)) +
  theme_bw() +
  geom_smooth(method = "lm", na.rm = TRUE)

gP_jitter_alpha

# test whether resistance from MIC is correlated with  resistance from disk diffusion
cor_test <- cor.test(Calb_R$MIC, Calb_R$disk, method = "spearman")
cor_test_tidy <- tidy(cor_test)
cor_test_tidy$p.value

# Programmatic figure save
pdf(here("figures_out", "190411Calb_R_MIC_disk.pdf"), width = 4, height = 4)
gP_jitter_alpha
dev.off()

