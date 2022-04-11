# Social Media and Web Analytics: Computing Lecture 1

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![lifecycle](https://img.shields.io/badge/version-2022-red.svg)]()

## Learning Objectives

By the end of this class you should be able to:

* Use the Twitter API to access recent tweets that contain a set of keywords
* Restrict the output of the Twitter API to return tweets based on geo-location, language and type of tweet (retweet, replies etc)
* Transform a dataset of Tweets to only contain connections between users based on retweets or mentions
* Transform a dataset of connections between users into a network
* Visualize a network of connections between Twitter users and save the output to file

## Instructions for Students (Before Coming to Class)

### You need a Twitter Account to work through the material!

Parts of this lecture use the Twitter API to get access to recent tweets.
To interact with the Twitter API you need to have an account with Twitter.
Sign up for an account before coming to class!

### Accessing Materials & Following Along Live in Class

Clone a copy of this repository using Git.
To clone a copy of this repository to your own PC:

```{bash, eval = FALSE}
git clone https://github.com/tisem-digital-marketing/smwa-lab-01.git
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

* `tidyr`
* `dplyr`
* `readr`
* `rtweet`
* `tidygraph`
* `ggraph`

Install these packages before coming to class.

## Meta-Information

* Module Maintainer: Lachlan Deer (`@lachlandeer`)
* Course: [Social Media and Web Analytics](https://tisem-digital-marketing.github.io/2022-smwa)
* Institute: Dept of Marketing, Tilburg University
* Current Version: [2022 edition](https://tisem-digital-marketing.github.io/2022-smwa)

## License

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

## Suggested Citation

Deer, Lachlan. 2022. Social Media and Web Analytics: Computing Lecture 1 - Collecting Social Media Data and Visualizing Social Media Networks. Tilburg University. url = "https://github.com/tisem-digital-marketing/smwa-computing-lecture-twitter-networks"

```{r, engine='out', eval = FALSE}
@misc{smwa-compllecture01-2022,
      title={"Social Media and Web Analytics: Computing Lecture 1 - Collecting Social Media Data and Visualizing Social Media Networks"},
      author={Lachlan Deer},
      year={2022},
      url = "https://github.com/tisem-digital-marketing/smwa-computing-lecture-twitter-networks"
}
```