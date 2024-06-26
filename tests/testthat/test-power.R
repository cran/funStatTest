# WARNING - Generated by {fusen} from dev/flat_package.Rmd: do not edit by hand

test_that("power_exp", {
    
    check_res <- function(res, stat, n_simu) {
        checkmate::expect_list(res, len = 3)
        expect_equal(names(res), c("power_res", "pval_res", "simu_config"))
        checkmate::expect_list(res$power_res, len = length(stat))
        expect_equal(names(res$power_res), stat)
        for(stat_name in stat) {
            cat("# stat:", stat_name, "\n")
            n_stat <- switch (stat_name, "hkr" = 2, 1)
            checkmate::qexpect(
                res$power_res[[stat_name]], 
                stringr::str_c("N", n_stat, "[0,1]")
            )
        }
        checkmate::expect_list(res$pval_res, len = length(stat))
        expect_equal(names(res$pval_res), stat)
        for(stat_name in stat) {
            cat("# stat:", stat_name, "\n")
            n_stat <- switch (stat_name, "hkr" = 2, 1)
            checkmate::expect_matrix(
                res$pval_res[[stat_name]], mode = "numeric", 
                any.missing = FALSE, 
                nrows = n_stat, ncols = n_simu, 
            )
            checkmate::qassert(
                res$pval_res[[stat_name]], 
                stringr::str_c("N", n_stat*n_simu, "[0,1]")
            )
        }
        for(stat_name in stat) {
            cat("# stat:", stat_name, "\n")
            for(ind in 1:nrow(res$pval_res[[stat_name]])) {
                expect_equal(
                    unname(res$power_res[[stat_name]][ind]),
                    sum(res$pval_res[[stat_name]][ind,] < alpha)/n_simu
                )
            }
        }
        checkmate::expect_list(res$simu_config, len = 7)
        expect_equal(
            names(res$simu_config), 
            c("n_simu", "c_val", "distrib", "delta_shape", "n_point", 
              "n_obs1", "n_obs2")
        )
    }
    
    n_simu <- 10
    alpha <- 0.05
    n_perm <- 100
    verbose <- FALSE
    n_point <- 20
    n_obs1 <- 4
    n_obs2 <- 5
    c_val <- 10
    delta_shape <- "constant"
    distrib <- "normal"
    max_iter <- 10000
    
    stat <- "mo"
    res <- power_exp(
        n_simu, alpha, n_perm, stat, n_point, n_obs1, n_obs2, c_val, 
        delta_shape, distrib, max_iter, verbose)
    check_res(res, stat, n_simu)
    
    stat <- "hkr"
    res <- power_exp(
        n_simu, alpha, n_perm, stat, n_point, n_obs1, n_obs2, c_val, 
        delta_shape, distrib, max_iter, verbose)
    check_res(res, stat, n_simu)
    
    stat <- c("mo", "med", "wmw", "hkr", "cff")
    res <- power_exp(
        n_simu, alpha, n_perm, stat, n_point, n_obs1, n_obs2, c_val, 
        delta_shape, distrib, max_iter, verbose)
    check_res(res, stat, n_simu)
})
