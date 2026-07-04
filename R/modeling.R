library(readr)
library(dplyr)
library(nnet) 
library(MASS)       
library(glmnet)     
library(caret)

set.seed(123)
wcmatches <- readRDS("data/processed/wcmatches.rds")

df_modelo <- wcmatches %>%
  dplyr::select(outcome, home_score, away_score, goals_per_match, stage_type, year) %>%
  mutate(
    outcome = as.factor(outcome),
    stage_type = as.factor(stage_type)
  )

idx <- sample(seq_len(nrow(df_modelo)), size = round(0.7 * nrow(df_modelo)))
train <- df_modelo[idx, ]
test  <- df_modelo[-idx, ]

modelo_base <- nnet::multinom(outcome ~ ., data = train)
modelo_null <- nnet::multinom(outcome ~ 1, data = train)

modelo_step <- stepAIC(modelo_null,
                       scope = list(lower = modelo_null, upper = modelo_base),
                       direction = "both",
                       trace = FALSE)
summary(modelo_step)

pred_step <- predict(modelo_step, newdata = test, type = "class")
confusionMatrix(as.factor(pred_step), test$outcome)

#para ridge y lasso
X_train <- model.matrix(outcome ~ ., train)[, -1]
y_train <- train$outcome
X_test  <- model.matrix(outcome ~ ., test)[, -1]

modelo_ridge <- cv.glmnet(X_train, y_train, family = "multinomial", alpha = 0)

modelo_lasso <- cv.glmnet(X_train, y_train, family = "multinomial", alpha = 1)

pred_ridge <- predict(modelo_ridge, X_test, s = "lambda.min", type = "class")
pred_lasso <- predict(modelo_lasso, X_test, s = "lambda.min", type = "class")

confusionMatrix(as.factor(pred_ridge), test$outcome)
confusionMatrix(as.factor(pred_lasso), test$outcome)


acc <- data.frame(
  Modelo   = c("StepAIC", "Ridge", "Lasso"),
  Accuracy = c(
    mean(pred_step  == test$outcome),
    mean(pred_ridge == test$outcome),
    mean(pred_lasso == test$outcome)
  )
)
acc