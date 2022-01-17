#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(colourpicker)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  #Définition des volets de l'appilcation#
  navbarPage(
    title="Covid Reporter",
    #==# Premier espace #====================================================#
    tabPanel("Bilan Global", {
      sidebarLayout(sidebarPanel(
        #--# Side panel (bouton de parametrage #-----------------------------#)
        "Salut patoche!!!!"
        ),
      mainPanel(
        #--# Main panel (Affichage graphique #-------------------------------#)
        "salut copaing",
        verticalLayout(
            "C'est moi patick!"
            ),
        verticalLayout(
          "Et ce sont mes copaing:",
            splitLayout(
              plotOutput(outputId = "graph_gen_hosp_001"),
              plotOutput(outputId = "graph_gen_dc_001")
              ),
          "Salut moi c'est géraldine",
          "Salut moi c'est Georges",
          "Salut moi c'est Philippe"
            ),
        
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
