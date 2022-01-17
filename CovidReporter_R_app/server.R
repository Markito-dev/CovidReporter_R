#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


#==============================================================================#
# ------------------------- Installation librairies ---------------------------#
#==============================================================================#

#install.packages("rvest")
#install.packages("dplyr")
#install.packages("ggplot2")

library(ggplot2)
library(rvest)
library(dplyr)
library(shiny)

#==============================================================================#
# ------------------------ Importing R function file --------------------------#
#==============================================================================#

source("function_file.R")

#==============================================================================#
# ------------------------------- Web Scrapping -------------------------------#
#==============================================================================#
url <- "https://www.data.gouv.fr/fr/datasets/donnees-hospitalieres-relatives-a-lepidemie-de-covid-19/"
download.file(url = url, "datagouv.html")
html <- read_html("datagouv.html")
html_c <- html_children(html)
html_wanted <- html %>% html_nodes('.card-body')
pos <- Position(x = html_wanted, f = function(x){ grepl("donnees-hospitalieres-covid19",html_text(x))})
html_wanted2 <- html_wanted[pos] %>% html_nodes('a') %>% html_attr('href')
l_html = length(html_wanted2)
link <- html_wanted2[l_html-1]

df_hebdo_covid <- read.csv(link, sep=";")
head(df_hebdo_covid,10)


#==============================================================================#
# ------------------------- Traitement des données --------------------------- #
#==============================================================================#
# 1- Regroupement des données par jour sur l'ensemble du territoire français --#
#    ps: Ici sexe=0 signifie que l'on fait aucune distinction de genre
df_data_fr <- df_hebdo_covid %>% filter(df_hebdo_covid$sexe == 0) %>% group_by(jour) %>% summarise(
  hosp = sum(hosp),
  rea = sum(rea),
  HospConv = sum(HospConv),
  SSR_USLD = sum(SSR_USLD),
  autres = sum(autres),
  dc = sum(dc)
)
df_data_fr[is.na(df_data_fr)] <- 0
df_data_fr

# 1(bis) - On sépare les données par années pour afficher certains graphiques--#
df_data_fr_2020<-df_data_fr %>% filter((as.Date(jour) < as.Date("2021-01-01")) & (as.Date(jour) > as.Date("2019-12-31")))
df_data_fr_2021<-df_data_fr %>% filter((as.Date(jour) < as.Date("2022-01-01")) & (as.Date(jour) > as.Date("2020-12-31"))) 
df_data_fr_2022<-df_data_fr %>% filter((as.Date(jour) < as.Date("2023-01-01")) & (as.Date(jour) > as.Date("2021-12-31"))) 


# 2 - Construction des graphiques généraux ------------------------------------#
   # - # Bilan global================
        # Main page =================
graph_gen_hosp_001 <- Affiche_all_hosp_periode(df_data_fr)
#graph_gen_hosp_001 # Graph fonctionnel!

graph_gen_dc_001 <- Affiche_dc_periode(df_data_fr)
#output$graph_gen_dc_001 <- renderPlot({graph_gen_dc_001})
#graph_gen_dc_001 # Graph fonctionnel!



#==============================================================================#
# ---------------------------------- Serveur ----------------------------------#
#==============================================================================#
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$graph_gen_hosp_001 <- renderPlot({graph_gen_hosp_001})
  output$graph_gen_dc_001 <- renderPlot({graph_gen_dc_001})
  
})
