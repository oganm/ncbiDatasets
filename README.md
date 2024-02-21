Readme
================

This is a very simple wrapper around the NCBI dataset command line tools
that just executes a desired command and reads the data into R.

``` r
orthologues = datasets('download',"gene gene-id 59272 --ortholog all")
ls(orthologues)
```

    ## [1] "data_report"     "dataset_catalog" "protein"         "rna"

``` r
# gene ids of the orthologues
orthologues$data_report %>% purrr::map_chr('geneId') %>% head
```

    ## [1] "100602708" "101993255" "102205204" "103009000" "104261683" "104334989"

``` r
# rna sequences imported as ape objects
orthologues$rna
```

    ## 867 DNA sequences in binary format stored in a list.
    ## 
    ## Mean sequence length: 3159.07 
    ##    Shortest sequence: 1035 
    ##     Longest sequence: 9940 
    ## 
    ## Labels:
    ## XM_009940668.1 ACE2 [organism=Opisthocomus hoazin] [GeneID=1...
    ## XM_032561507.1 ace2 [organism=Xiphophorus hellerii] [GeneID=...
    ## XM_034116723.1 ace2 [organism=Trematomus bernacchii] [GeneID...
    ## XM_058088754.1 ace2 [organism=Doryrhamphus excisus] [GeneID=...
    ## XM_061408099.1 ACE2 [organism=Bos javanicus] [GeneID=1332420...
    ## XM_061408100.1 ACE2 [organism=Bos javanicus] [GeneID=1332420...
    ## ...
    ## 
    ## Base composition:
    ##     a     c     g     t 
    ## 0.294 0.212 0.237 0.257 
    ## (Total: 2.74 Mb)
