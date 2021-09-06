#' jme4
#'
#' Fit a mixed model using julia
#' @param formula formula
#' @param data data object
#' @param family family
#' @export

jme4 <- function(formula, data, family = NULL){

  # Initiate julia
  j <- suppressMessages(JuliaCall::julia_setup())
  j$install_package_if_needed("MixedModels")
  j$install_package_if_needed("DataFrames")
  j$install_package_if_needed("JellyMe4")
  j$install_package_if_needed("RCall")
  # Set libraries
  j$library("MixedModels")
  j$library("DataFrames")


  # Set up model dependencies
  j$assign("data", data)

  chr_form <- gsub("\\.", "_",formula)

  if(is.null(family)){
    command <- glue::glue("myfit = fit(MixedModel, @formula({chr_form}), data)")
  }else{
    if(family == "binomial") family <- "Bernoulli"
    if(family == "poisson") family <- "Poisson"
    command <- glue::glue("myfit = fit(MixedModel, @formula({chr_form}), data, {family}())")
  }

  j$eval(command, need_return = "Julia")
  j$library("JellyMe4")
  if(is.null(family)){
  model <- j$eval("robject(:lmerMod, Tuple([myfit,data]))", need_return="R")
  }else{
    model <- j$eval("robject(:glmerMod, Tuple([myfit,data]))", need_return="R")
  }

  model

}
