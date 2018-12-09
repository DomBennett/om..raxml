pkgnm <- environmentName(env = environment())

#' @name raxml
#' @title raxml
#' @description Run raxml
#' @param ... Arguments
#' @example examples/raxml.R
#' @export
raxml <- function(...) {
  arglist <- outsider::.arglist_get(...)
  files_to_send <- outsider::.filestosend_get(arglist)
  arglist <- outsider::.arglist_parse(arglist)
  otsdr <- outsider::.outsider_init(repo = 'dombennett/om..raxml',
                                    cmd = 'raxmlHPC-PTHREADS-SSE3',
                                    wd = getwd(),
                                    files_to_send = files_to_send,
                                    arglist = arglist)
  outsider::.run(otsdr)
}
