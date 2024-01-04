library(rvest)
library(stringr)
library(dplyr)
library(rio)

############################################################################## #
###                                                                            #
### PROVIDE YOUR SETTINGS HERE                                              ####
### Please fill in your specifications and then run the code                   #
###                                                                            #
############################################################################## #

## Insert Search String here!
# For tips on how to create a good search string for google scholar check out
# http://musingsaboutlibrarianship.blogspot.com/2015/10/6-common-misconceptions-when-doing.html
searchstring <- 'intitle:("OPEN SCIENCE BADGES" & "TRUST" & "SCIENTISTS")'

## Which range of results should be exported?
# Please provide in increments of 10
# (otherwise this will be enforced, the script can only export entire pages of 10)
from_result <- 1
to_result <- 100



############################################################################## #
###                                                                            #
### ONLY RUN THIS CODE                                                      ####
### Without changing anything                                                  #
###                                                                            #
############################################################################## #

# create empty object to save results
references <- data.frame(authors = as.character(),
                         year = as.character(),
                         title = as.character(),
                         journal = as.character(),
                         abstract = as.character())

for (i in (seq(from = from_result, to = to_result, by = 10)-1)) { # a loop to scrape from several pages
  # create URL of google scholar result page
  url <- URLencode(paste0("https://scholar.google.com/scholar?start=", 
                          i,              # indicates page
                          "&as_vis=1&q=", # excludes citations (checkbox on the left)
                          searchstring),  # passes the search string
                   reserved = F)    # makes sure special characters are not encoded
  
  # scrape this juicy results page
  page <- read_html(url) 
  Sys.sleep(1)
  
  for (j in 1:10) { # loop over all 10 results
    # extract certain details from the result
    references <- references %>% 
      add_row(authors = gsub("^(.*?)\\W+-\\W+.*", "\\1", 
                             rvest::html_text(rvest::html_elements(page, ".gs_a")), 
                             perl = TRUE)[j],
              year = ifelse(str_detect(rvest::html_text(rvest::html_elements(page, ".gs_a"))[j],
                                       "(\\d{4})"),   # if year is detected
                            gsub("^.*(\\d{4}).*", "\\1", # then extract year
                                 rvest::html_text(rvest::html_elements(page, ".gs_a")),
                                 perl = TRUE)[j],
                            as.character(NA)),        # else missing value
              title = rvest::html_text(rvest::html_elements(page, ".gs_rt"))[j],
              journal = ifelse(str_detect(rvest::html_text(rvest::html_elements(page, ".gs_a"))[j],
                                          "(\\d{4})"), # if year is detected
                               gsub("^.*((?<=-\\s)(.*)(?=,+)).*", "\\1",  # then
                                    rvest::html_text(rvest::html_elements(page, ".gs_a")),
                                    perl = TRUE)[j],
                               gsub("^.*((?<=-\\s)(.*)).*$", "\\1",       # else
                                    rvest::html_text(rvest::html_elements(page, ".gs_a")),
                                    perl = TRUE)[j]),
              abstract = rvest::html_text(rvest::html_nodes(page, ".gs_rs"))[j]
      )
  }
}


# clean up the messy titles
references <- references |>
  dplyr::mutate(title = stringr::str_replace_all(
    title,
    "(\\[PDF\\]\\[PDF\\]\\s|\\[HTML\\]\\[HTML\\]\\s|\\[BUCH\\]\\[B\\]\\s)", 
    ""))

## Export the data set to the working directory as CSV
# This CSV is compatible for import to Rayyan and ASReview
rio::export(references, "references_googleScholar.csv")
