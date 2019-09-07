table <- function(data){
  bracket <- ")"
  data %>% 
    filter(int %in% c(0,1,2,6,7,8)) %>% 
    mutate_if(is.numeric, round,1) %>% 
    unite("riskCI95", c("pd_llim95", "pd_ulim95"), sep = ",", remove = TRUE) %>% 
    unite("r", c("pd", "riskCI95"), sep = " (", remove = TRUE) %>% 
    mutate(Riesgo = glue("{r}{bracket}")) %>% 
    unite("rrCI95", c("RR_llim95", "RR_ulim95"), sep = ", ", remove = TRUE) %>%
    unite("risk_ratio", c("rr", "rrCI95"), sep = " (", remove = TRUE) %>%
    mutate(RR = glue("{risk_ratio}{bracket}")) %>%
    unite("rdCI95", c("RD_llim95", "RD_ulim95"), sep = ", ", remove = TRUE) %>%
    unite("risk_diff", c("rd", "rdCI95"), sep = " (", remove = TRUE) %>%
    mutate(DR = glue("{risk_diff}{bracket}")) %>%
    mutate(int2 = case_when(
      int == 0 ~ "0. Curso natural",
      int == 1 ~ "1. Mantener PAS < 120 mmHg",
      int == 2 ~ "2. Mantener PAS < 140 mmHg",
      int == 6 ~ "3. Dejar de fumar (si fuma actualmente)",
      int == 7 ~ "4. Intervencion 1 + 3",
      int == 8 ~ "5. Intervencion 2 + 3",
      TRUE ~ int2)) %>% 
    select(int2, Riesgo, RR, DR, intervened) %>% 
    rename(`Intervencion` = int2,
           `Riesgo Relativo` = RR,
           `Diferencia de Riesgo` = DR,
           `Total Intervenido %` = intervened) %>% 
    kable() %>% 
    kable_styling(bootstrap_options = c("hover", "responsive"), full_width = TRUE,
                  font_size = 15) %>% 
    footnote(general = "PAS: Presion arterial sistolica, 500 bootstraps.")
}


set_long <- function(df){
  df_long <- df %>% 
    clean_names() %>% 
    mutate(risk0 = 0,
           comprisk0 = 0) %>% 
    select(sample, int2, int, risk0, starts_with("risk"), comprisk0, starts_with("comp")) %>% 
    gather("surv_risk", "prob", risk0:comprisk15, -c(sample, int2, int), na.rm = FALSE, convert = TRUE) %>% 
    mutate(risk = str_extract(surv_risk, "[aA-zZ]+"),
           time = parse_number(surv_risk)) %>% 
    select(-surv_risk) %>% 
    spread(risk, prob, convert = TRUE) %>% 
    mutate(risk = round((risk*100), 2),
           comprisk_surv = round(((1 - comprisk)*100), 2),
           comprisk = round((comprisk*100), 2),
           int = as.factor(int),
           int2 = case_when(
             int == 0 ~ "0. Curso natural",
             int == 1 ~ "1. Mantener PAS < 120 mmHg",
             int == 2 ~ "2. Mantener PAS < 140 mmHg",
             int == 6 ~ "3. Dejar de fumar (si fuma actualmente)",
             int == 7 ~ "4. Intervencion 1 + 3",
             int == 8 ~ "5. Intervencion 2 + 3",
             TRUE ~ int2),
           int2 = as.factor(int2))
  
  df_long_0 <- df_long %>% filter(sample == 0)
  df_long_1 <- df_long %>% filter(sample != 0)
  df_long_1%>% 
    group_by(int, int2, time) %>% 
    summarise(risk_min = quantile(risk, 0.05),
              risk_max = quantile(risk, 0.95),
              comprisk_min = quantile(comprisk, 0.05),
              comprisk_max = quantile(comprisk, 0.95)) %>% 
    left_join(df_long_0) %>% 
    select(starts_with("int"), time, starts_with("risk"), starts_with("comprisk"))
}

surv_graph <- function(df, a, b, c) {
  outcome <- c
  inter_name <- df[df$int == b & df$time == 1, "int2"]
  df %>% 
    filter(int == a| int == b) %>%
    ggplot() +
    aes(x = time, y = risk, group = int) +
    geom_line(aes(x = time, y = risk, color = int2), size = 1.1) + 
    scale_color_manual(values = c("#235AA7", "#FFDB6D")) +
    geom_ribbon(aes(ymin = risk_min, ymax = risk_max ), alpha = 0.10) +
    labs(title = glue("Incidencia acumulada de {outcome} en 15 anos de seguimiento"),
         x = "Anos de seguimiento",
         y = "Incidencia acumulada %",
         color = "Intervencion") +
    scale_y_continuous(limits = c(0, 12), breaks=seq(0,12, 2)) +
    theme_minimal() +
    theme(legend.position = 'bottom')}


