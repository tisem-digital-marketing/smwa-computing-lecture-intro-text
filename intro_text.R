#' intro_text.R
#' 
#' Contributors:
#' 
#' What this file does:
#'  - Introduces students to first founding concepts in text analytics

# --- Libraries --- #
library(readr)     # read files
library(janitor)   # cleanup var names
library(dplyr)     # data manip
library(tibble)    # work with dataframe
library(tidyr)     # data manip
library(ggplot2)   # plotting
library(stringr)   # work with strings
library(tidytext)  # work with text - main functionality
library(textstem)  # stem words
library(tokenizers) # count words
library(reshape2)  # cast from long to wide and vice versa
library(wordcloud) # plot wordclouds

# --- Load Data --- #
df <-
    read_csv('data/ebay_reviews.csv') %>%
    clean_names()

# --- Reducing the Data Size --- #
df %>%
    group_by(category) %>%
    count(sort = TRUE)

to_keep <-
    c('Digital Cameras', 'Headphones')

select_categ <- 
    df %>%
    filter(category %in% to_keep)

# --- Counting Characters and Approx. Word Counts --- #
select_categ <- 
    select_categ %>%
    mutate(n_char = nchar(review_content),
           n_words = count_words(review_content)
           )

select_categ %>%
    ggplot() +
    geom_histogram(
       aes(x = n_words)
    ) +
    #scale_x_continuous(trans = 'log1p') +
    facet_wrap(~category)

# --- Reviews to Tokens --- #

tokens <-
    select_categ %>%
    rownames_to_column("id") %>%
    unnest_tokens(word, review_content) %>%
    select(id, category, rating, word)

# common words ? 
common_words <-
    tokens %>%
    group_by(word) %>%
    count()

# --- Stop Words --- # 
stop_words

common_words <-
    tokens %>%
    anti_join(stop_words) %>%
    group_by(word, category) %>%
    count(sort = TRUE) %>%
    ungroup()

common_words %>%
    group_by(category) %>%
    top_n(25) %>%
    # ggplot(aes(n, 
    #            reorder_within(word, n, category)
    #            )
    #        ) +
    ggplot(aes(n,
               word
               )
           ) +
    geom_col() +
    scale_y_reordered() +
    facet_wrap(~category, scales = "free") +
    labs(y = NULL)

#--- Custom Stop Words --- #

custom_stop_words <- 
    tibble(
        word = c(
            'camera',
            'cameras',
            'review',
            'canon',
            'bose',
            'headphones'
        ),
        lexicon = 'ebay'
    )

common_words <-
    tokens %>%
    anti_join(stop_words) %>%
    anti_join(custom_stop_words) %>%
    group_by(word, category) %>%
    count(sort = TRUE) %>%
    ungroup()

common_words %>%
    group_by(category) %>%
    top_n(25) %>%
    ggplot(aes(n, 
               reorder_within(word, n, category)
    )
    ) +
    geom_col() +
    scale_y_reordered() +
    facet_wrap(~category, scales = "free") +
    labs(y = NULL)

# --- Stemming --- #
tokens_no_stop <-
    tokens %>%
    anti_join(stop_words) %>%
    anti_join(custom_stop_words)

tokens_stem <-
    tokens_no_stop %>%
    mutate(word_lemma = lemmatize_words(word))

common_words2 <-
    tokens_stem %>%
    group_by(word_lemma, category) %>%
    count(sort = TRUE) %>%
    ungroup()

common_words2 %>%
    group_by(category) %>%
    top_n(25) %>%
    ggplot(aes(n, 
               reorder_within(word_lemma, n, category)
    )
    ) +
    geom_col() +
    scale_y_reordered() +
    facet_wrap(~category, scales = "free") +
    labs(y = NULL)

# --- TF-IDF --- #
# The idea of tf-idf is to find the important words for the content 
# of each document by decreasing the weight for commonly used words 
# and increasing the weight for words that are not used very much in a 
# collection or corpus of documents, in this case, the group of XX as a whole. 
# Calculating tf-idf attempts to find the words that are important (i.e., common) 
# in a text, but not too common. Let’s do that now.

review_tfidf <-
    tokens_stem %>%
    group_by(category) %>%
    count(word_lemma, sort = TRUE) %>%
    bind_tf_idf(word_lemma, category, n)

review_tfidf %>%
    group_by(category) %>%
    top_n(25) %>%
    ggplot(aes(n, 
               reorder_within(word_lemma, tf_idf, category)
    )
    ) +
    geom_col() +
    scale_y_reordered() +
    facet_wrap(~category, scales = "free") +
    labs(y = NULL)
# note this suggests some extra stop words we might wanna remove ..
# its an iterative process..

# --- Word Clouds --- #
# lets focus only on digital cameras
camera_tokens <- 
    tokens_stem %>%
    filter(category == 'Digital Cameras')

# Separate into good and bad reviews based on rating
# ignore neutral for now
camera_tokens <-
    camera_tokens %>%
    mutate(rating_simple = 
               case_when(
                   rating == 4 | rating == 5 ~ "positive",
                   rating == 1 | rating == 2 ~ "negative",
                   TRUE ~ "neutral"
               )
    ) %>%
    filter(rating_simple != "neutral")

camera_tokens %>%
    count(word_lemma, rating_simple, sort = TRUE) %>%
    acast(word_lemma ~ rating_simple, value.var = "n", fill = 0) %>%
    comparison.cloud(colors = c("red", "green"),
                     max.words = 75)

camera_tokens %>%
    count(word_lemma, rating_simple, sort = TRUE) %>%
    acast(word_lemma ~ rating_simple, value.var = "n", fill = 0) #%>%
    commonality.cloud(max.words = 75)
