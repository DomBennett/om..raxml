pkgnm <- environmentName(env = environment())

#' @name raxml
#' @title raxml
#' @description Run raxml
#' @param ... Arguments
#' @example examples/raxml.R
#' @export
raxml <- function(...) {
  args <- outsider::.args_parse(...)
  files_to_send <- outsider::.which_args_are_filepaths(args)
  outsider::.run(pkgnm = pkgnm, files_to_send = files_to_send,
                 'raxmlHPC-PTHREADS-SSE3', args)
}
