pkgnm <- environmentName(env = environment())

#' @name raxml
#' @title raxml
#' @description Run raxml
#' @param arglist Arguments to raxml provided as a character vector
#' @example examples/raxml.R
#' @export
raxml <- function(arglist = arglist_get(...)) {
  files_to_send <- filestosend_get(arglist)
  arglist <- arglist_parse(arglist)
  otsdr <- outsider_init(pkgnm = 'om..raxml', cmd = 'raxmlHPC-PTHREADS-SSE3',
                         wd = getwd(), files_to_send = files_to_send,
                         arglist = arglist)
  run(otsdr)
}
