##### Three-level MA issue minimum reproducible example ------------------------

# Uses the meta package to run a three-level meta-analysis (id) with
# sub-groups (byvar)

# Where one sub-group (group C) includes multiple data points from one study
# (Plain 2019) using a single reference group  

# The following error is thrown:
### Error: $ operator is invalid for atomic vectors ###

## open packages
library(meta)
library(metafor)

## create dataframe
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

## planned three-level MA ----------
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

## three-level MA without sub-groups  ----------
ma2 <- metagen(TE = te, seTE = se, sm = paste("OR"), 
              studlab = paste(study), 
              data = df,
              id = ref_group,
              fixed = FALSE, random = TRUE)

#produce forest plot
forest(x = ma2, 
       leftcols = "studlab", overall = TRUE,
       subgroup = TRUE, print.subgroup.labels = TRUE, study.results = TRUE)

## three-level MA excluding Plain 2019  ----------

df_sub <- subset(df, df$exposure_topic!="C")

ma3 <- metagen(TE = te, seTE = se, sm = paste("OR"), 
              studlab = paste(study), 
              data = df_sub,
              subgroup = exposure_topic, 
              subgroup.name = "Exposure topic",
              id = ref_group,
              fixed = FALSE, random = TRUE)

#produce forest plot
forest(x = ma3, 
       leftcols = "studlab", overall = TRUE,
       subgroup = TRUE, print.subgroup.labels = TRUE, study.results = TRUE)

