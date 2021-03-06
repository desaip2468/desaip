logistic_rocr_curve <- function(data, items.regex) {
  x <- data %>% filter(age >= 50)
  x[x$approval_real_price_sum_by_by_approval_type_LT01 > 0,"approval_real_price_sum_by_by_approval_type_LT01"] = 1
  x$approval_real_price_sum_by_by_approval_type_LT01 <- factor(x$approval_real_price_sum_by_by_approval_type_LT01)

  target <- x %>% select('approval_real_price_sum_by_by_approval_type_LT01')

  # log(1+X)
  items_data <- log(x %>% select(matches(items.regex)) + 1)
  items <- cbind(target, items_data)

  items_split <- sample.split(items$approval_real_price_sum_by_by_approval_type_LT01, SplitRatio = 0.90)
  items_train <- items %>% filter(items_split)
  items_test <- items %>% filter(!items_split)

  set.seed(217)
  balanced.items <- SMOTE(approval_real_price_sum_by_by_approval_type_LT01 ~., items_train, perc.over =200, k = 5, perc.under = 150)

  model_items <- glm(approval_real_price_sum_by_by_approval_type_LT01~., data=balanced.items, family = binomial)

  predict_items <- predict(model_items, items_test, type = 'response')
  ROCRpred <- prediction(predict_items, items_test$approval_real_price_sum_by_by_approval_type_LT01)
  ROCRperf <- performance(ROCRpred, 'tpr','fpr')

  auc <- performance(ROCRpred, measure = "auc")
  auc <- auc@y.values[[1]]
  plot(ROCRperf, colorize = TRUE, text.adj = c(-0.2,1.7))
  mtext(paste("AUC: ", auc), side=3)
}
