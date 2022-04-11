# plot_twitter_network.R
#
# Contributors:
#
# What this file does:
#   * Transforms returned Twitter data into a network of connections
#   * Plots retweet and Mentions networks

# --- Libraries --- #
library(readr)     # read/write files
library(dplyr)     # data manip
library(tidyr)     # data manip
library(tidygraph) # network data
library(ggraph)    # network viz

# --- Load Data --- #
tweets <-
    read_rds("data/tweets.Rds")

# --- Retweet Network --- #
# Connect users who retweet each other

# Filter for retweets
rt <- 
    tweets %>%
    filter(is_retweet == TRUE)    

# We need screen_name and retweet_screen_name only
# (and only the distinct pairs, since we don't care
# how many times A retweets B)
# These are the edges of our network 

rt_edge <-
    rt %>%
    select(from = screen_name, 
           to = retweet_screen_name) %>%
    distinct()

# ok so there's a lot of connections here...
# lets reduce the sample size to make things a little easier

to_counts <-
    rt_edge %>%
    group_by(to) %>%
    count() %>%
    arrange(desc(n))

from_counts <-
    rt_edge %>%
    group_by(from) %>%
    count() %>%
    arrange(desc(n))

# lets keep folks who have >= 3 retweets

from_filter <- 
    from_counts %>%
    filter(n >= 3)

rt_edge_small <-
    rt_edge %>%
    filter(from %in% from_filter$from)

# turn edgelist into a network graph object
rt_graph <- 
    as_tbl_graph(
        rt_edge_small, 
        directed = FALSE
        )

# Plot
ggraph(rt_graph, layout = 'fr') + 
    geom_edge_link(alpha = 0.2) + 
    geom_node_point() +
    theme_bw()

# Save
ggsave("retweet_network.pdf")

# --- Mentions Network --- #

mnt <- 
    tweets %>%
    select(from = screen_name, 
           to = mentions_screen_name
           ) %>%
    filter(to != "NA")

# looking at that data frame we see that to can take multiple values
# if more than one person is mentioned. Let's unnest that

mnt <- 
    mnt %>%
    unnest_longer(to) %>%
    distinct()

# if a user is writing a thread, then they mention themselves
# lets remove that too

mnt <-
    mnt %>%
    filter(from != to)

# ok so there's a lot of connections here...
# lets reduce the sample size to make things a little easier

to_counts <-
    rt_edge %>%
    group_by(to) %>%
    count() %>%
    arrange(desc(n))

from_counts <-
    rt_edge %>%
    group_by(from) %>%
    count() %>%
    arrange(desc(n))

# lets keep folks who mention at least 3 distinct people
from_filter <- 
    from_counts %>%
    filter(n >= 3)

mnt_small <-
    mnt %>%
    filter(from %in% from_filter$from)

# Convert to a network graph
mnt_grph <- as_tbl_graph(mnt_small)

# Plot it

ggraph(mnt_grph, 
       layout = 'fr'
    ) +
    geom_node_point() +
    geom_edge_link(alpha = 0.2) +
    theme_bw()

# Plot w/ a different
ggraph(mnt_grph, 
       layout = "linear", 
       circular = TRUE
       ) +
    geom_node_point() +
    geom_edge_link(alpha = 0.2) +
    theme_void()

# Save
ggsave("mentions_network.pdf")
