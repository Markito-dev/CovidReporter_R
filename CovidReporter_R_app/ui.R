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
library(leaflet)
library(shinydashboard)

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
    tabPanel("Bilan Global", 
      
        fluidRow(column(width = 4,
        h3("CHIFFRES CLEFS",align = "center"),
        #--# Side panel (bouton de parametrage #-----------------------------#)
          
          verticalLayout(
            h4(textOutput(outputId = "Titre_gen_recap_001")),
            textOutput(outputId = "Titre_nb_hosp_001"),
            textOutput(outputId = "nb_hosp_001"),
            textOutput(outputId = "Titre_nb_rea_001"),
            textOutput(outputId = "nb_rea_001"),
            textOutput(outputId = "Titre_nb_dc_001"),
            textOutput(outputId = "nb_dc_001"),
            
            h4(textOutput(outputId = "Titre_gen_recap_002")),
            textOutput(outputId = "Titre_nb_hosp_002"),
            textOutput(outputId = "nb_hosp_002"),
            textOutput(outputId = "Titre_nb_rea_002"),
            textOutput(outputId = "nb_rea_002"),
            textOutput(outputId = "Titre_nb_dc_002"),
            textOutput(outputId = "nb_dc_002"),
            
            h4(textOutput(outputId = "Titre_gen_recap_003")),
            textOutput(outputId = "Titre_nb_hosp_003"),
            textOutput(outputId = "nb_hosp_003"),
            textOutput(outputId = "Titre_nb_rea_003"),
            textOutput(outputId = "nb_rea_003"),
            textOutput(outputId = "Titre_nb_dc_003"),
            textOutput(outputId = "nb_dc_003"),
            
            h4(textOutput(outputId = "Titre_gen_recap_004")),
            textOutput(outputId = "Titre_nb_hosp_004"),
            textOutput(outputId = "nb_hosp_004"),
            textOutput(outputId = "Titre_nb_rea_004"),
            textOutput(outputId = "nb_rea_004"),
            textOutput(outputId = "Titre_nb_dc_004"),
            textOutput(outputId = "nb_dc_004"),

            h4(textOutput(outputId = "Titre_gen_recap_005")),
            textOutput(outputId = "Titre_nb_hosp_005"),
            textOutput(outputId = "nb_hosp_005"),
            textOutput(outputId = "Titre_nb_rea_005"),
            textOutput(outputId = "nb_rea_005"),
            textOutput(outputId = "Titre_nb_dc_005"),
            textOutput(outputId = "nb_dc_005"),
            ),
        ),
      column(width = 7,
        
        #--# Main panel (Affichage graphique #-------------------------------#)
        h1("BILAN GENERAL",align="center"),
        tabsetPanel(
          tabPanel("Hospitalisation", radioButtons("choix_bilan_01","Type de bilan", c("Global","Ce mois","2022","2021","2020"), selected="Global",inline = TRUE),
                                      plotOutput(outputId = "graph_gen_hosp_001",
                                                            width = "800px",
                                                            height = "500px")
                                        
                   ), 
          tabPanel("Décès", radioButtons("choix_bilan_02","Type de bilan", c("Global","Ce mois","2022","2021","2020"), selected="Global",inline = TRUE),
                                     plotOutput(outputId = "graph_gen_dc_001",
                                                            width = "800px",
                                                            height = "500px")
                   ),
          tabPanel("Données", 
                   fluidRow(
                     column(width = 9,dataTableOutput(outputId ="CovidData_gen")),
                     column(width = 2,downloadButton("downloadData_001", "Download"))
                     )
                  )
        )
        
        )# end column
      ) # end FluidRow
      ),
    #=========================================================================#
    #==# Deuxième espace #====================================================#
    tabPanel("Bilan detaille", 
             fluidRow(column(width = 4,
                             h3("Parametres",align = "center"),
                             dateRangeInput("DateRange", "Date range:",
                                            start  = "2020-03-19",
                                            end    = as.character.Date(Sys.Date()),
                                            min    = "2020-03-18",
                                            max    = as.character.Date(Sys.Date())
                                            ),
                             radioButtons("choix_graphe","choix", c("Hospitalisation","Reanimation","Conventionnelle","SSR_USLD","Autres"), selected="Reanimation"),
                             
                            ),
                      column(width = 7,
                             
                             #--# Main panel (Affichage graphique #-------------------------------#)
                             h1("GRAPHIQUES",align="center"),
                             tabsetPanel(
                                           tabPanel("Hospitalisations", plotOutput(outputId = "graph_mod_hosp_001",
                                                               width = "800px",
                                                               height = "500px")
                                                    
                                                    ), 
                                           tabPanel("Décès",plotOutput(outputId = "graph_mod_dc_001",
                                                               width = "800px",
                                                               height = "500px")
                                                    ),
                                           tabPanel("Carte", leafletOutput("map_mod_serv_001") )
                                        )
                             
                              )#End column
                      )#End FluidRow
            ),#End tabPanel
    
    #=========================================================================#
    #==# Troisième espace #===================================================#
    tabPanel("features upcoming", "content coming soon")
    )
  
))
