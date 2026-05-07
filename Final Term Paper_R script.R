#Elizabeth Hagan
#PhD Student, School of Government and Public Policy
#Linear regression 2 Final Term Paper
#Exploring how Europeans’ perceptions of climate change shape their adoption of pro-environmental behaviours

#Set work directory
setwd("C:/Users/acer/Desktop/SGPP/sem 2/Quant 2/class-project/Data Analysis")


#Load data
install.packages("foreign") 
library(foreign)

load("C:/Users/acer/Desktop/SGPP/sem 2/Quant 2/class-project/Dataset/ICPSR_36403-V1(2)/ICPSR_36403/DS0001/36403-0001-Data.rda")
df <- da36403.0001
cat("Loaded:", nrow(df), "rows x", ncol(df), "columns\n")


#Data cleaning
#Convert factor variables to numeric
df_clean <- as.data.frame(lapply(df, function(x) {if (is.factor(x)) as.numeric(x) else x}))

#Recode missing variables to NA
df_clean[df_clean == 98 | df_clean == 99 | df_clean == 999] <- NA

#Rename variables

df_clean$severity   <- ifelse(df_clean$QA2 == 11, NA, df_clean$QA2)
df_clean$personalresponsibility <- ifelse(df_clean$QA3_5 == 2, 1, 0)
df_clean$behaviour <- rowSums(ifelse(df_clean[, paste0("QA6_", 1:11)] == 2, 1, 0), na.rm = TRUE)
df_clean$ideology   <- ifelse(df_clean$D1 %in% c(11, 12), NA, df_clean$D1)
df_clean$socialclass <- ifelse(df_clean$D63 %in% 1:5, df_clean$D63, NA)
df_clean$country    <- df_clean$COUNTRY


#Descriptive Statistics

# Severity
cat("\nSeverity (QA2):\n")
summary(df_clean$severity)
sd(df_clean$severity, na.rm = TRUE)
table(df_clean$severity, useNA = "always")

# Behaviour
cat("\nPro-action (QA6 index):\n")
summary(df_clean$behaviour)
sd(df_clean$behaviour, na.rm = TRUE)
table(df_clean$behaviour, useNA = "always")


# Ideology
cat("\nIdeology (D1):\n")
summary(df_clean$ideology)
sd(df_clean$ideology, na.rm = TRUE)
table(df_clean$ideology, useNA = "always")


# Social Class
cat("\nSocial Class (D63):\n")
summary(df_clean$socialclass)
sd(df_clean$socialclass, na.rm = TRUE)
table(df_clean$socialclass, useNA = "always")

#Personal responsibility

table(df_clean$personalresponsibility, useNA = "always")
prop.table(table(df_clean$personalresponsibility, useNA = "always"))
summary(df_clean$personalresponsibility)

cat("\nPersonal Responsibility (QA3_5):\n")
summary(df_clean$personalresponsibility)
sd(df_clean$personalresponsibility, na.rm = TRUE)
table(df_clean$personalresponsibility, useNA = "always")


#Model 1

#bivariate association between perceived severity and ideology

cor.test(df_clean$severity, df_clean$ideology,  na.rm=T)

#estimating perceived climate change severity as a function of political ideology 

model1 <- lm(df_clean$severity ~ df_clean$ideology)
summary(model1)

# Exporting the table of model_1 to HTML using stargazer

library(stargazer)

stargazer(model1,
          type = "html",
          out = "severity and ideology.html",
          summary = FALSE,
          rownames = FALSE,
          title = "Model 1",  dep.var.labels = "Ideology)",
          digits = 3)

#RQ2
#Pro-Environmental Behaviour 

#Create dummy variable for country effect

df_clean$country_f <- factor(df_clean$country)
df_clean$country_f <- relevel(df_clean$country_f, ref = "1")


#Additive model


fit_additive<-lm(df_clean$behaviour~df_clean$severity + df_clean$ideology + df_clean$socialclass + df_clean$personalresponsibility +
                    df_clean$country_f,data = df_clean)
summary(fit_additive)


#Interaction model

fit_interaction<-lm(df_clean$behaviour~df_clean$severity + df_clean$ideology + df_clean$socialclass + df_clean$personalresponsibility + 
             df_clean$country_f+ df_clean$country_f*df_clean$ideology,data = df_clean)

summary(fit_interaction)


# F-test, comparing the additive and interactive models.

anova(fit_additive, fit_interaction)


# Visualise slopes of additive and interaction models

png("slope_plots.png", width = 1200, height = 600, res = 120)

par(mfrow = c(1, 2), mar = c(4, 4, 3, 2))

# --- Plot 1: Additive Model slopes --------------------------
plot(NULL, xlim = c(1, 10), ylim = c(3, 5),
     xlab = "Predictor Value",
     ylab = "Predicted Behaviour",
     main = "Additive Model Slopes")

abline(a = coef(fit_additive)["(Intercept)"],
       b = coef(fit_additive)["df_clean$severity"],
       col = "steelblue", lwd = 2.5)

abline(a = coef(fit_additive)["(Intercept)"],
       b = coef(fit_additive)["df_clean$ideology"],
       col = "darkorange", lwd = 2.5)

abline(a = coef(fit_additive)["(Intercept)"],
       b = coef(fit_additive)["df_clean$socialclass"],
       col = "darkgreen", lwd = 2.5)

abline(a = coef(fit_additive)["(Intercept)"],
       b = coef(fit_additive)["df_clean$personalresponsibility"],
       col = "purple", lwd = 2.5)

legend("topleft",
       legend = c("Severity", "Ideology", "Social Class", "Personal Responsibility"),
       col    = c("steelblue", "darkorange", "darkgreen", "purple"),
       lwd = 2.5, bty = "n", cex = 0.8)

# --- Plot 2: Interaction Model slopes -----------------------
plot(NULL, xlim = c(1, 10), ylim = c(3, 5),
     xlab = "Predictor Value",
     ylab = "Predicted Behaviour",
     main = "Interaction Model Slopes")

abline(a = coef(fit_interaction)["(Intercept)"],
       b = coef(fit_interaction)["df_clean$severity"],
       col = "steelblue", lwd = 2.5)

abline(a = coef(fit_interaction)["(Intercept)"],
       b = coef(fit_interaction)["df_clean$ideology"],
       col = "darkorange", lwd = 2.5)

abline(a = coef(fit_interaction)["(Intercept)"],
       b = coef(fit_interaction)["df_clean$socialclass"],
       col = "darkgreen", lwd = 2.5)

abline(a = coef(fit_interaction)["(Intercept)"],
       b = coef(fit_interaction)["df_clean$personalresponsibility"],
       col = "purple", lwd = 2.5)

legend("topleft",
       legend = c("Severity", "Ideology", "Social Class", "Personal Responsibility"),
       col    = c("steelblue", "darkorange", "darkgreen", "purple"),
       lwd = 2.5, bty = "n", cex = 0.8)

dev.off()

#Robustness Check

# Breusch-Pagan test for additive model
bptest(fit_additive)

# Breusch-Pagan test for interaction model
bptest(fit_interaction)


#Corrections

library(sandwich)
cat("=== OLS Standard Errors ===\n")
coeftest(fit_additive)
cat("=== HC1 (White) Robust Standard Errors ===\n")


coeftest(fit_additive, vcov = vcovHC(fit_additive, type = "HC1"))

Comparing  OLS and Robust Errors

ols_se <- sqrt(diag(vcov(fit_additive)))
robust_se <- sqrt(diag(vcovHC(fit_additive, type = "HC1")))

comparison <- data.frame(
  OLS = round(ols_se, 6),
  Robust_HC1 = round(robust_se, 6)
)
comparison |> knitr::kable()
