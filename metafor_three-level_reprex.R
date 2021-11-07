##### Three-level MA issue minimum reproducable example ------------------------

# When using the metafor package to run a three-level meta-analysis (id) and
# sub-groups (byvar), where one sub-group included 

library(metafor)

df <- data.frame(study = c("Brown 2011, exposed, males", 
                           "Brown 2011, exposed, females",
                           "Grant 2014, exposed, both sexes",
                           "Young 2012, medium exposed, both sexes",
                           "Young 2012, high exposed, both sexes",
                           "Plain 2019, medium exposed/medium dose, both sexes",
                           "Plain 2019, medium exposed/high dose, both sexes",
                           "Plain 2019, high exposed/medium dose, both sexes",
                           "Plain 2019, high exposed/high dose, both sexes"),
                 ref_group = c("Brown 2011, unexposed, males",
                               "Brown 2011, unexposed, males",
                               "Grant 2014, unexposed, both sexes",
                               "Young 2012, unexposed, both sexes",
                               "Young 2012, unexposed, both sexes",
                               "Plain 2019, unexposed, both sexes",
                               "Plain 2019, unexposed, both sexes",
                               "Plain 2019, unexposed, both sexes",
                               "Plain 2019, unexposed, both sexes"),
                 te = c(0.63, 0.77, 1.08, 1.23, 1.25,0.66, 0.78, 0.87, 0.93),
                 se = c(0.24, 0.16, 0.34, 0.28, 0.27,0.13, 0.18, 0.12, 0.17),
                 exposure_topic = c("A","A","B","B","B","C","C","C","C"))




ma <- metagen(TE = te, seTE = se, sm = paste("OR"), 
                  studlab = paste(study), 
                  data = df,
                  subgroup = exposure_topic, 
                  subgroup.name = "Exposure topic",
                  id = ref_group,
                  fixed = FALSE, random = TRUE)


#produce forest plot
forest(x = ma, 
       leftcols = "studlab", overall = TRUE,
       subgroup = TRUE, print.subgroup.labels = TRUE, study.results = TRUE)
