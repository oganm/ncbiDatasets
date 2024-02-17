#' datasets wrapper
#'
#' This is a simple wrapped for the datasets command line tool.
#'
#' @param do "summary" or "download"
#' @param args all other arguments as a vector
#' @param file file path to save the output if desired
#'
#' @examples
#' datasets('download',"gene gene-id 59272 --ortholog all")
#'
#' @export
datasets = function(do = c('summary','download'),args,file = NULL){

    do = match.arg(do)
    if (is.null(file)){
        f = tempfile()
    } else{
        f = file
    }

    if (do == 'download'){
        args = c(args,paste('--filename',f))
    }

    args = c(do,args)

    out = system2(datasets_path(),args = args,stdout = TRUE, stderr = TRUE)

    if(do == 'summary'){
        if(!is.null(file)){
            writeLines(out,file)
        }

        return(jsonlite::fromJSON(out,simplifyVector = FALSE))
    } else if(do =='download'){
        tmp = tempfile()
        dir.create(tmp,recursive = TRUE)
        unzip(f,exdir = tmp)
        files = list.files(file.path(tmp,'ncbi_dataset/data'),
                           full.names = TRUE,
                           recursive = TRUE)

        out <- lapply(files,function(x){
            ext = tools::file_ext(x)
            if (ext == 'jsonl'){
                return(readLines(x) %>% lapply(jsonlite::fromJSON,simplifyVector = FALSE))
            } else if(ext == 'json'){
                return(readLines(x) %>% jsonlite::fromJSON(simplifyVector = FALSE))
            } else if(ext =='faa'){
                return(ape::read.FASTA(x,type = "AA"))
            } else if(ext =='fna'){
                return(ape::read.FASTA(x,type = "DNA"))
            } else{
                return(NULL)
            }
        })

        names(out) = files %>% basename() %>% tools::file_path_sans_ext()
        return(out)
    }

}

