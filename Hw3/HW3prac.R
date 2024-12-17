library(plotly)
library(tidyr)
library(dplyr)
library(EUfootball)
library(ggplot2)

el_classico_data <- Matches %>%
  filter((Home == "Real Madrid" & Guest == "Barcelona") | 
           (Home == "Barcelona" & Guest == "Real Madrid"))

el_classico_data <- el_classico_data %>%
  mutate(Result = case_when(
    (Home == "Real Madrid" & Goals90Home > Goals90Guest) ~ "Win",
    (Home == "Real Madrid" & Goals90Home < Goals90Guest) ~ "Loss",
    (Home == "Real Madrid" & Goals90Home == Goals90Guest) ~ "Draw",
    (Home == "Barcelona" & Goals90Home < Goals90Guest) ~ "Win",
    (Home == "Barcelona" & Goals90Home > Goals90Guest) ~ "Loss",
    (Home == "Barcelona" & Goals90Home == Goals90Guest) ~ "Draw"
  ))


el_classico_data <- el_classico_data %>%
  mutate(Location = ifelse(Home == "Real Madrid", "Home", "Away"))


outcomes_summary <- el_classico_data %>%
  group_by(Location, Result) %>%
  summarise(Count = n(), .groups = "drop")


ggplot(outcomes_summary, aes(x = Location, y = Count, fill = Result)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "El Clásico Record: Wins, Losses, and Draws (Real Madrid vs Barcelona)",
       x = "Match Location",
       y = "Count",
       fill = "Outcome") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5))


