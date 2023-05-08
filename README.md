# Social Media and Web Analytics: Computing Lecture - Intro to Text as Data

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![lifecycle](https://img.shields.io/badge/version-2023-red.svg)]()

## Learning Objectives

By the end of this class you should be able to:

* Explain the advantages and disadvantages of using text as data
* Compute the number of characters and words within a piece of text
* Define the terms unigram, token, stopword, word stem and TF-IDF 
* Transform a dataset of text into a dataset of tokens
* Remove standard and customized stopwords from a data set of tokens
* Visualize the most common words used in a data set of tokens
* Lemmatize a set of tokens and explain the advantages of doing so
* Compute a TF-IDF metric on a set of tokens
* Explain the output of a statistical command that produces TF-IDF scores
* Visualize word clouds that show common or distinguishing words between two categories of text
## Instructions for Students (Before Coming to Class)

### Accessing Materials & Following Along Live in Class

Clone a copy of this repository using Git.
To clone a copy of this repository to your own PC:

```{bash, eval = FALSE}
git clone https://github.com/tisem-digital-marketing/smwa-computing-lecture-intro-text.git
```

Once you have cloned the files, open the cloned repository in RStudio as an RStudio project and use the empty R scripts to follow along with the lecture as we work through material.

At the conclusion of the class, the course instructor's scripts are made available in the branch `instructor`.
Recall that you can switch between branches using the `git branch <BRANCHNAME>` command in a terminal.
Thus to switch to the instructor branch:

```{bash}
git branch instructor
```

And to switch back to the branch that you worked through live in class:

```{bash}
git branch main
```

*NOTE*: Git does not like you to switch branches with uncommitted changes.
Before you switch branches, be sure to commit any changes to the files.

### Installing required packages

This lecture makes use of additional `R` packages:

* janitor 
* readr  
* dplyr 
* tibble
* tidyr  
* ggplot2
* stringr
* tidytext
* textstem  
* tokenizers
* reshape2 
* wordcloud

Install these packages before coming to class.

## Meta-Information

* Module Maintainer: Lachlan Deer (`@lachlandeer`)
* Course: [Social Media and Web Analytics](https://tisem-digital-marketing.github.io/2023-smwa)
* Institute: Dept of Marketing, Tilburg University
* Current Version: [2023 edition](https://tisem-digital-marketing.github.io/2023-smwa)

## License

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

## Suggested Citation

Deer, Lachlan. 2022. Social Media and Web Analytics: Computing Lecture 2 - Introduction to Text as Data Methods. Tilburg University. url = "https://github.com/tisem-digital-marketing/smwa-computing-lecture-intro-text"

```{r, engine='out', eval = FALSE}
@misc{smwa-compllecture02-2023,
      title={"Social Media and Web Analytics: Computing Lecture - Introduction to Text as Data"},
      author={Lachlan Deer},
      year={2023},
      url = "https://github.com/tisem-digital-marketing/smwa-computing-lecture-intro-text"
}
```