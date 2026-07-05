tema_fifa <- function() {
  theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0, face = "bold"),
      legend.position = "bottom"
    )
}

calc_accuracy <- function(pred, real) {
  round(mean(pred == real) * 100, 2)
}

tabla_modelos <- function(modelos, accuracies) {
  data.frame(Modelo = modelos, Accuracy = paste0(accuracies, "%"))
}