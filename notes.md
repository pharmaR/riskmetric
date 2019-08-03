Reworking terminology

Package metadata collection classes:
+ list_of_pkg_meta
+ pkg_meta
   + pkg_install_meta
   + pkg_source_meta
   + pkg_remote_meta
       + pkg_cran_remote_meta
       + pkg_bioc_remote_meta
       + pkg_mran_remote_meta


Assessment function calls
  assess_ (e.g. assess_has_news) => metric_meta_
  returns class:
    + list_of_metric_meta
    + metric_meta
       + metric_meta_* (e.g. c(metric_meta_has_news, metric_meta))

    
Score
  score
  returns class:
    + list_of_metric_score
    + metric_score


pkg_ref(c(...)) %>%
  build_metric_metadata() %>%   # build generic metadata objects for each metric
  score() %>%
  mutate(risk = summarize_risk(.))
  
  
  

