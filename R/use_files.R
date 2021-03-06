#' Use Files
#' 
#' These functions download files from external sources and put them inside the www directory. 
#' 
#' @inheritParams  add_module
#' @param url String representation of URL for the file to be downloaded
#' @param dir Path to the dir where the file while be created.
#' @note See `?htmltools::htmlTemplate` and `https://shiny.rstudio.com/articles/templates.html` for more information about `htmlTemplate`.
#' @export
#' @rdname use_files
#' @importFrom cli cat_bullet
#' @importFrom fs path_abs path
use_external_js_file <- function(
  url,
  name,
  pkg = get_golem_wd(), 
  dir = "inst/app/www",
  open = FALSE, 
  dir_create = TRUE
){
  
  old <- setwd(path_abs(pkg))  
  on.exit(setwd(old))
  
  if (missing(name)){
    name <- basename(url)
  }
  
  name <-  file_path_sans_ext(name)
  new_file <- sprintf( "%s.js", name )
  
  dir_created <- create_if_needed(
    dir, type = "directory"
  )
  
  if (!dir_created){
    cat_dir_necessary()
    return(invisible(FALSE))
  }
  
  dir <- path_abs(dir) 
  
  where <- path(
    dir, new_file
  )
  
  if (fs::file_exists(where)){
    cat_exists(where)
    return(invisible(FALSE))
  }
  
  if ( file_ext(url) != "js") {
    cat_red_bullet(
      "File not added (URL must end with .js extension)"
    )
    return(invisible(FALSE))
  }
  
  cat_start_download()
  
  utils::download.file(url, where)
  
  file_created_dance(
    where, 
    after_creation_message_js, 
    pkg, 
    dir, 
    name,
    open, 
    catfun = cat_downloaded
  )
  
}

#' @export
#' @rdname use_files
#' @importFrom fs path_abs
use_external_css_file <- function(
  url,
  name,
  pkg = get_golem_wd(), 
  dir = "inst/app/www",
  open = FALSE, 
  dir_create = TRUE
){
  
  old <- setwd(path_abs(pkg))  
  on.exit(setwd(old))
  
  if (missing(name)){
    name <- basename(url)
  }
  
  name <-  file_path_sans_ext(name)
  new_file <- sprintf("%s.css", name)
  
  dir_created <- create_if_needed(
    dir, type = "directory"
  )
  
  if (!dir_created){
    cat_dir_necessary()
    return(invisible(FALSE))
  }
  
  dir <- path_abs(dir) 
  
  where <- path(
    dir, new_file
  )
  
  if (fs::file_exists(where)){
    cat_exists(where)
    return(invisible(FALSE))
  }
  
  if ( file_ext(url) != "css") {
    cat_red_bullet(
      "File not added (URL must end with .css extension)"
    )
    return(invisible(FALSE))
  }
  
  cat_start_download()
  
  utils::download.file(url, where)
  
  file_created_dance(
    where, 
    after_creation_message_css, 
    pkg, 
    dir, 
    name,
    open, 
    catfun = cat_downloaded
  )
  
}

#' @export
#' @rdname use_files
#' @importFrom fs path_abs
use_external_html_template <- function(
  url,
  name = "template.html",
  pkg = get_golem_wd(), 
  dir = "inst/app/www",
  open = FALSE, 
  dir_create = TRUE
){

  old <- setwd(path_abs(pkg))  
  on.exit(setwd(old))
  
  new_file <- sprintf(
    "%s.html", 
    file_path_sans_ext(name)
  )
  
  dir_created <- create_if_needed(
    dir, type = "directory"
  )
  
  if (!dir_created){
    cat_dir_necessary()
    return(invisible(FALSE))
  }
  
  dir <- path_abs(dir) 
  
  where <- path(
    dir, new_file
  )
  
  if (fs::file_exists(where)){
    cat_exists(where)
    return(invisible(FALSE))
  }
  
  cat_start_download()
  
  utils::download.file(url, where)
  
  cat_downloaded(where)
  
  file_created_dance(
    where, 
    after_creation_message_html_template, 
    pkg, 
    dir, 
    name,
    open
  )
  
}

#' @export
#' @rdname use_files
#' @importFrom fs path_abs
use_external_file <- function(
  url,
  name,
  pkg = get_golem_wd(), 
  dir = "inst/app/www",
  open = FALSE, 
  dir_create = TRUE
){
  
  if (missing(name)){
    name <- basename(url)
  }
  
  old <- setwd(path_abs(pkg))  
  on.exit(setwd(old))
  
  dir_created <- create_if_needed(
    dir, type = "directory"
  )
  
  if (!dir_created){
    cat_dir_necessary()
    return(invisible(FALSE))
  }
  
  dir <- path_abs(dir) 
  
  where <- path(
    dir, name
  )
  
  if (fs::file_exists(where)){
    cat_exists(where)
    return(invisible(FALSE))
  }
  
  cat_start_download()
  
  utils::download.file(url, where)
  
  cat_downloaded(where)
  
}
