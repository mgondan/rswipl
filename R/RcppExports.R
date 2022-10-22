.init <- function(argv0) {
    .Call('_rswipl_init_', PACKAGE = 'rswipl', argv0)
}

.done <- function() {
    .Call('_rswipl_done_', PACKAGE = 'rswipl')
}
