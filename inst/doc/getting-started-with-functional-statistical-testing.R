## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(funStatTest)

## ----setup_seed---------------------------------------------------------------
# fix seed for simulations
set.seed(123456)

## ----examples-simul_traj------------------------------------------------------
simu_vec <- simul_traj(100)
plot(simu_vec, xlab = "point", ylab = "value")

## ----examples-simulate_data---------------------------------------------------
simu_data <- simul_data(
    n_point = 100, n_obs1 = 50, n_obs2 = 75, c_val = 10, 
    delta_shape = "constant", distrib = "normal"
)
str(simu_data)

## ----examples-plot_simu-------------------------------------------------------
# constant delta
simu_data <- simul_data(
    n_point = 100, n_obs1 = 50, n_obs2 = 75, c_val = 5, 
    delta_shape = "constant", distrib = "normal"
)
plot_simu(simu_data)
# linear delta
simu_data <- simul_data(
    n_point = 100, n_obs1 = 50, n_obs2 = 75, c_val = 5, 
    delta_shape = "linear", distrib = "normal"
)
plot_simu(simu_data)
# quadratic delta
simu_data <- simul_data(
    n_point = 100, n_obs1 = 50, n_obs2 = 75, c_val = 5, 
    delta_shape = "quadratic", distrib = "normal"
)
plot_simu(simu_data)

## ----examples-stat_mo---------------------------------------------------------
simu_data <- simul_data(
    n_point = 100, n_obs1 = 50, n_obs2 = 75, c_val = 10, 
    delta_shape = "constant", distrib = "normal"
)

MatX <- simu_data$mat_sample1
MatY <- simu_data$mat_sample2

stat_mo(MatX, MatY)

## ----examples-stat_med--------------------------------------------------------
simu_data <- simul_data(
    n_point = 100, n_obs1 = 50, n_obs2 = 75, c_val = 10, 
    delta_shape = "constant", distrib = "normal"
)

MatX <- simu_data$mat_sample1
MatY <- simu_data$mat_sample2

stat_med(MatX, MatY)

## ----examples-stat_wmw--------------------------------------------------------
simu_data <- simul_data(
    n_point = 100, n_obs1 = 50, n_obs2 = 75, c_val = 10, 
    delta_shape = "constant", distrib = "normal"
)

MatX <- simu_data$mat_sample1
MatY <- simu_data$mat_sample2

stat_wmw(MatX, MatY)

## ----examples-stat_hkr--------------------------------------------------------
simu_data <- simul_data(
    n_point = 100, n_obs1 = 50, n_obs2 = 75, c_val = 10, 
    delta_shape = "constant", distrib = "normal"
)

MatX <- simu_data$mat_sample1
MatY <- simu_data$mat_sample2

stat_hkr(MatX, MatY)

## ----examples-stat_cff--------------------------------------------------------
simu_data <- simul_data(
    n_point = 100, n_obs1 = 50, n_obs2 = 75, c_val = 10, 
    delta_shape = "constant", distrib = "normal"
)

MatX <- simu_data$mat_sample1
MatY <- simu_data$mat_sample2

stat_cff(MatX, MatY)

## ----examples-comp_stat-------------------------------------------------------
simu_data <- simul_data(
    n_point = 100, n_obs1 = 50, n_obs2 = 75, c_val = 10, 
    delta_shape = "constant", distrib = "normal"
)

MatX <- simu_data$mat_sample1
MatY <- simu_data$mat_sample2

res <- comp_stat(MatX, MatY, stat = c("mo", "med", "wmw", "hkr", "cff"))
res

## ----examples-permut_pval-----------------------------------------------------
# simulate small data for the example
simu_data <- simul_data(
    n_point = 20, n_obs1 = 4, n_obs2 = 5, c_val = 10, 
    delta_shape = "constant", distrib = "normal"
)

MatX <- simu_data$mat_sample1
MatY <- simu_data$mat_sample2
res <- permut_pval(
    MatX, MatY, n_perm = 100, stat = c("mo", "med", "wmw", "hkr", "cff"), 
    verbose = TRUE)
res

## ----examples-power_exp-------------------------------------------------------
# simulate a few small data for the example
res <- power_exp(
    n_simu = 20, alpha = 0.05, n_perm = 100, 
    stat = c("mo", "med", "wmw", "hkr", "cff"), 
    n_point = 25, n_obs1 = 4, n_obs2 = 5, c_val = 10, delta_shape = "constant", 
    distrib = "normal", max_iter = 10000, verbose = FALSE
)
res$power_res

