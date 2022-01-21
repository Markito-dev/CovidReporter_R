#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#==============================================================================#
# -------------------------------- librairies ---------------------------------#
#==============================================================================#
library(shiny)
library(colourpicker)

#==============================================================================#
# ---------------------------------- Textes -----------------------------------#
#==============================================================================#
chiffres_clefs_str <- ""

#==============================================================================#
# ------------------------------------ UI -------------------------------------#
#==============================================================================#

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  #Définition des volets de l'appilcation#
  navbarPage(
    title="Covid Reporter",
    #==# Premier espace #====================================================#
    tabPanel("Bilan Global", {
      sidebarLayout(sidebarPanel(
        #--# Side panel (bouton de parametrage #-----------------------------#)
        h3("CHIFFRES CLEFS",align = "center"),
        verticalLayout(
          h4(textOutput(outputId = "Titre_gen_recap_001")),
          textOutput(outputId = "Titre_nb_hosp_001"),
          textOutput(outputId = "nb_hosp_001"),
          textOutput(outputId = "Titre_nb_rea_001"),
          textOutput(outputId = "nb_rea_001"),
          textOutput(outputId = "Titre_nb_dc_001"),
          textOutput(outputId = "nb_dc_001")
          ),
        verticalLayout(
          h4(textOutput(outputId = "Titre_gen_recap_002")),
          textOutput(outputId = "Titre_nb_hosp_002"),
          textOutput(outputId = "nb_hosp_002"),
          textOutput(outputId = "Titre_nb_rea_002"),
          textOutput(outputId = "nb_rea_002"),
          textOutput(outputId = "Titre_nb_dc_002"),
          textOutput(outputId = "nb_dc_002")
        ),
        verticalLayout(
          h4(textOutput(outputId = "Titre_gen_recap_003")),
          textOutput(outputId = "Titre_nb_hosp_003"),
          textOutput(outputId = "nb_hosp_003"),
          textOutput(outputId = "Titre_nb_rea_003"),
          textOutput(outputId = "nb_rea_003"),
          textOutput(outputId = "Titre_nb_dc_003"),
          textOutput(outputId = "nb_dc_003")
        ),
        verticalLayout(
          h4(textOutput(outputId = "Titre_gen_recap_004")),
          textOutput(outputId = "Titre_nb_hosp_004"),
          textOutput(outputId = "nb_hosp_004"),
          textOutput(outputId = "Titre_nb_rea_004"),
          textOutput(outputId = "nb_rea_004"),
          textOutput(outputId = "Titre_nb_dc_004"),
          textOutput(outputId = "nb_dc_004")
        ),
      ),
        
      mainPanel(
        #--# Main panel (Affichage graphique #-------------------------------#)
        h1("BILAN GENERALE",align="center"),
        verticalLayout(
            ),
        verticalLayout(
              plotOutput(outputId = "graph_gen_hosp_001"),
              plotOutput(outputId = "graph_gen_dc_001")
            )
        
        )# end mainPanel
      ) # end sidebarPanel
      }),
    
    #==# Deuxième espace #====================================================#
    tabPanel("Bilan detaille", {
      sidebarLayout(sidebarPanel(
      #--# Side panel (bouton de parametrage #-----------------------------#)
         "Salut patoche!!!!"
          ),
      mainPanel(
      #--# Main panel (Affichage graphique #-------------------------------#)
          "Salut germaine!!!!"
          )
      )}),
    
    #==# Troisième espace #====================================================#
    tabPanel("features upcoming", "content coming soon")
    )
  
))
