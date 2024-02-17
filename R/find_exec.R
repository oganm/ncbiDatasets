find_arch = function(){
    os = R.version$os
    arch = R.version$arch
    if(grepl('linux',os) & arch == 'x86_64'){
        return('linux-amd64')
    } else if(grepl('linux',os) & grepl('arm64',arch)){
        return('linux-arm64')
    } else if(grepl('linux',os) & grepl('arm',arch)){
        return('linux-arm')
    } else if(grepl('^darwin',os)){
        return('mac')
    } else if(Sys.info()[1] =='Windows'){
        return('win64')
    }

}

get_path = function(){
    system.file(find_arch(),package = 'ncbiDatasets')
}

datasets_path = function(x){
    file.path(get_path(),'datasets')
}

dataformat_path = function(x){
    file.path(get_path(),'dataformat')
}
