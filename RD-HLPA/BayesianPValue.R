# common functions for reproducible reporting
#  - Bayesian framework R/brms interface to Stan
#  - editable vector figures in PowerPoint
#  - estimates P-values with emmeans

#source("/opt/fix-rstudio.R")
#Sys.setenv(TZ="CET")
require("tidyverse")
require(readxl) # normal Excel input
require("openxlsx") # for normal write xlsx format
# require("tidyxl") # for complicated Excel layouts
# require("unpivotr") # for complicated Excel layouts

require("officer")
require("rvg")
require("modelr")
require("tidybayes")
require("ggstance")
require("ggridges")
require("cowplot")
require("patchwork")
require("latex2exp")
require("rstan")
require("brms")
require("emmeans")
require("flextable")
require("viridis")
require("ggsci")
require("RColorBrewer")
require("processx")

rstan_options(javascript=FALSE)
rstan_options(auto_write = TRUE)
min.cores.parallel <- 4
Sys.setenv(MAKEFLAGS = paste0("-j",min(min.cores.parallel, parallel::detectCores() - 1)))
my.cores <- min(min.cores.parallel, parallel::detectCores() - 1) #DEBUG# leave one free core to keep system responsive
options(mc.cores = my.cores)

theme_set(theme_light())
S_width <- 13.33 / 2.0
S_height <- 7.5 / 2
plt <- list()

path_notify <- "D:/DS/utils/notify/notify.exe"

# colourCount = 10
# getPalette = colorRampPalette(brewer.pal(8, "Set2"))

# my.colors = c(brewer.pal(name="Set2", n = 8), brewer.pal(name="Dark2", n = 3))
my.colors = c("#008B8B", "#696969", "#BA55D3", "#679B9B", "#E79C2A", "#F56FAD", "#9C19E0", "#FF9A76", "#637373")

# add stars to p.values
signif.num <- function(x) {
  as.character(symnum(x, corr = FALSE, na = FALSE, legend = FALSE,
                      cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                      symbols = c("***", "**", "*", ".", " ")))
}

# color significan emm summary in light green
emm_show <- function(myemm, myDraws = NULL) {
  set.seed(1) # reproducible mvt-adjustment for P-value
  myft <- summary(myemm, infer=TRUE, frequentist=TRUE, adjust="mvt") %>% as_tibble

  # leave only p.value column
  myft <- myft %>% select(one_of(setdiff( names(myft),
    c("emmean", "response", "estimate", "rate", "prob", "SE", "df",
      "asymp.LCL", "asymp.UCL",  "z.ratio")
    ) ) ) %>%
    select( -ends_with(".trend") )

  if(is.null(myDraws)) {
    myft.median_hdi <- summary(myemm)
    myft <- merge(myft.median_hdi, myft, sort=FALSE, all=TRUE)
  } else {
    myft.median_hdi <- myDraws %>%
      median_hdci() %>%
      ungroup() %>%
      select(
        one_of(setdiff(names(myft), c("p.value"))),
        .value, .lower, .upper) %>%
      rename(median=.value, lower.HPD=.lower, upper.HPD=.upper)
    myft <- merge(myft.median_hdi, myft, sort=FALSE, all.x=TRUE, all.y=FALSE)
  }
  # return(myft) #DEBUG# to dump power analysis simulations to file

  myft <- flextable(myft)
  myft <- bold(myft, i = ~ lower.HPD*upper.HPD > 0, bold = TRUE)
  myft <- bg(myft, i = ~ p.value >= 0.05 & lower.HPD*upper.HPD > 0, j = ~ p.value, bg="yellow")
  myft <- fontsize(myft, part = "all", size = 10)
  myft <- set_formatter(myft, p.value = function(x) sprintf("%.2e", x) )
  autofit(myft)
}

set_emm_pvalue <- function(myemm) {
  set.seed(1) # reproducible mvt-adjustment for P-value
  myft <- summary(myemm, infer=TRUE, frequentist=TRUE, adjust="mvt") %>% as_tibble
  
  # leave only p.value column
  myft <- myft %>% select(one_of(setdiff( names(myft),
                                          c("emmean", "response", "estimate", "rate", "prob", "SE", "df",
                                            "asymp.LCL", "asymp.UCL",  "z.ratio")
  ) ) ) %>%
    select( -ends_with(".trend") )
  return(myft)
}

emm_inorder <- function(myemm) {
  # yield draws, restoring correct order of groups (work around a bug of R/tidybayes)
  gather_emmeans_draws(myemm) %>% ungroup %>% mutate_if(is.character, fct_inorder)
}

my.stat_eyeh <- function(ggp, ...) {
  ggp +
    stat_halfeye(point_interval = median_hdci, .width = 0.95,
             shape = 16, point_color = "black", interval_color = "black",
             slab_color = NA, normalize="groups", orientation = "horizontal", ... ) +
    # scale_fill_brewer(palette = "Set2") +
    # scale_fill_manual(values = getPalette(colourCount)) +
    # scale_fill_manual(values = my.colors) +
    scale_color_brewer(palette = "Dark2")
}

my.stat_eye <- function(ggp, ...) {
  ggp +
    stat_eye(point_interval = median_hdci, .width = 0.95,
             shape = 16, point_color = "black", interval_color = "black", 
             position="dodge", slab_color = NA, 
             # normalize="height",
             ... ) +
    # scale_fill_brewer(palette = "Set2") + 
    # scale_color_brewer(palette = "Dark2") +
    scale_color_brewer(palette = "Dark2") +
    # scale_fill_manual(values = my.colors) +
    theme(axis.text.x = element_text(angle = 30, hjust = 1))
}

my.legend <- function(...) {theme(
  legend.title = element_text(size=12, color = "salmon", face="bold"),
  # legend.justification=c(0,1), legend.position=c(0.05, 0.95),
  legend.background = element_blank(),
  legend.key = element_blank(), ...)}

notify <- function(title="Rstudio", msg="done") {
  
  args <- c(title, msg)
  run(path_notify, args)
  
  invisible()
}

