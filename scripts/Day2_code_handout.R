### ggplot & stats

# download the data from the internet
download.file("http://home.cc.umanitoba.ca/~gersteia/MBIO7040/Calb_resistance.csv",
              here("data_in", "Calb_resistance.csv"))

# load the data
Calb_R <- read_csv(here("data_in", "Calb_resistance.csv"))

# Install and then load a new package, `skimr`

# Plotting the distribution of one varible

## EXERCISE: Create a new figure with two panels, one panel for each gender that colours the different strain types differently. Use the help menus or “google fu” figure out how to add a title to the figure (whatever you like). Since dividing up the data into six categories makes it a bit sparse, play around with either bin or binwidth to find something that looks more pleasing.

# Install and then load the broom package

