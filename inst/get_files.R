library(here)
library(glue)

get_cmd = function(which,ext = ''){
    dir.create(here::here(glue::glue('inst/{which}')),
               recursive = TRUE, showWarnings = FALSE)

    download.file(destfile = here::here(glue::glue('inst/{which}/datasets')),
                  url = glue::glue("https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/{which}/datasets{ext}"))

    system(glue::glue('chmod +x ',here::here(glue::glue('inst/{which}/datasets'))))

    download.file(destfile = here::here(glue::glue('inst/{which}/dataformat')),
                  url = glue::glue("https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/{which}/dataformat{ext}"))
    system(glue::glue('chmod +x ',here::here(glue::glue('inst/{which}/dataformat'))))

}

get_cmd('linux-amd64')
get_cmd('mac')
get_cmd('win64','.exe')
get_cmd('linux-arm64')
get_cmd('linux-arm')

