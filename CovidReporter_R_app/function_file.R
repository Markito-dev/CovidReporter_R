

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
# ---------------------------------- Functions --------------------------------#
#==============================================================================#

# Affiche_all_hosp_periode ----------------------------------------------------#
Affiche_all_hosp_periode <- function(dataframe, deb_date = as.Date("2019-12-31"), end_date = as.Date("2100-12-31")) {
  sprintf("Period of analysis: %s -> %s",as.character.Date(deb_date),as.character.Date(end_date))
  #Filter part#
  df_filtered<-dataframe %>% filter((as.Date(jour) <= end_date) & (as.Date(jour) >= deb_date))
  date_min = min(as.character.Date(df_filtered$jour))
  date_max = max(as.character.Date(df_filtered$jour))
  #Graphic part#
  # Construction du titre
  title_label = paste("Nombre d'hospitalisation du au Covid19 dans les territoires francais\n du",
                      as.character.Date(date_min),
                      " au ",
                      as.character.Date(date_max))
  # Initialisation du graphique
  graph <- ggplot(df_filtered, aes(x=as.Date(jour))) + 
    
    # Edition du titre
    ggtitle(label = title_label, subtitle = "Repartition des hospitalisations par service")+
    
    # Edition des paramètres titre/legend
    theme(
      plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
      plot.subtitle = element_text(color = "#364167", hjust = 0.5),
      legend.position="bottom"
    )+
    # Edition des labels (ordonnées/abscisse)
    xlab("Date") + ylab("Nombre d'hospitalisation") +
    
    # Affichage des areas plot consernant les différents services
    geom_area(aes(y = rea+HospConv+SSR_USLD+autres, color = "reanimation", fill = "reanimation"), alpha=0.4)+ 
    geom_area(aes(y = hosp, color = "total", fill = "total"), alpha=0.1)+ 
    geom_area(aes(y = HospConv+SSR_USLD+autres, color = "conventionnelle", fill = "conventionnelle"), alpha=0.3)+
    geom_area(aes(y = SSR_USLD+autres, color = "SSR_ou_USLD", fill = "SSR_ou_USLD"), alpha=0.4)+
    geom_area(aes(y = autres, color = "autres", fill = "autres"), alpha=0.5)+
    
    # Paramétrage des couleurs des area plot et de la légende
    scale_color_manual("Hospitalisation", values=c(total="#457b9d",
                                                   reanimation ="#e76f51",
                                                   conventionnelle = "#fcbf49",
                                                   SSR_ou_USLD = "#588157" ,
                                                   autres = "#faedcd")) +  
    scale_fill_manual("Hospitalisation", values=c( total="#457b9d",
                                                   reanimation ="#e76f51",
                                                   conventionnelle = "#fcbf49",
                                                   SSR_ou_USLD = "#588157" ,
                                                   autres = "#faedcd"))
  
  return(graph)
  
}


# Affiche_dc_periode ----------------------------------------------------------#

Affiche_dc_periode <- function(dataframe, deb_date = as.Date("2019-12-31"), end_date = as.Date("2100-12-31")) {
  # Permet d'afficher sous forme de line plot la le nombre de décès dans une période donnée 
  sprintf("Period of analysis: %s -> %s",as.character.Date(deb_date),as.character.Date(end_date))
  #Filter part#
  df_filtered <- dataframe %>% filter((as.Date(jour) <= end_date) & (as.Date(jour) >= deb_date))
  date_min = min(as.character.Date(df_filtered$jour))
  date_max = max(as.character.Date(df_filtered$jour))
  #     print(as.character.Date(date_min))
  #Graphic part#
  # Area plot
  title_label = paste("Nombre de deces du au Covid19 dans les territoires francais\n du",
                      as.character.Date(date_min),
                      " au ",
                      as.character.Date(date_max))
  
  graph <- ggplot(df_filtered,
         aes(x=as.Date(jour))) + 
    #     
    ggtitle(label = title_label)+
    theme(
      plot.title = element_text(size = 14,
                                face = "bold",
                                hjust = 0.5),
      panel.grid.major.y = element_line(color = "#BBC5C0",
                                        size = 0.5))+
    xlab("Date") + ylab("Nombre de deces") +
    #     
    geom_area(aes(y = dc), fill = "#BBC5C0", 
              color = "#383837", alpha=0.2)
  
  return(graph)
}



# Filtre_departement ----------------------------------------------------------#

Filtre_departement <- function(dataframe, liste_dep = "all") {
  
  nb_dep = length(liste_region)
  
  #Print part of argument#
  if (liste_dep == "all"){
    print("On prend toutes les départements de france")
    df_filtered <- dataframe
  }else{
    if (nb_dep > 1){
      print("Sélection des départements:")
      for(dep in liste_dep){
        print(as.character(dep))
      }
    }else{
      print(paste("Sélection des départements: ",as.character(liste_dep)))
    }
    df_filtered <- dataframe %>% filter(as.character(dataframe$dep) %in% liste_dep)
  }
  
  #On regroupe les données par leur date#
  df_filtered <- df_filtered %>% filter(df_filtered$sexe == 0) %>% group_by(jour) %>% summarise(
    hosp = sum(hosp),
    rea = sum(rea),
    HospConv = sum(HospConv),
    SSR_USLD = sum(SSR_USLD),
    autres = sum(autres),
    dc = sum(dc)
  )
  df_filtered[is.na(df_filtered)] <- 0
  df_filtered
  
  #Return dataframe filtered#
  return(df_filtered)
}



# Affiche_hosp_periode --------------------------------------------------------#

Affiche_hosp_periode <- function(dataframe, deb_date = as.Date("2019-12-31"), end_date = as.Date("2100-12-31"),secteur_str = "autres" ) {
  sprintf("Period of analysis: %s -> %s",as.character.Date(deb_date),as.character.Date(end_date))
  
  #Filter part#
  df_filtered<-dataframe %>% filter((as.Date(jour) <= end_date) & (as.Date(jour) >= deb_date))
  date_min = min(as.character.Date(df_filtered$jour))
  date_max = max(as.character.Date(df_filtered$jour))
  
  #traitement des entr?e ( secteur )#
  if (secteur_str == "autres") {secteur <- df_filtered$autres}
  else if(secteur_str =="hospitalisation"){ secteur <- df_filtered$hosp}
  else if(secteur_str =="reanimation"){ secteur <- df_filtered$rea}
  else if(secteur_str == "Conventionelle"){ secteur <- df_filtered$HospConv}
  else if(secteur_str == "SSR_USLD"){secteur <- df_filtered$SSR_USLD}
  
  
  
  #Graphic part#
  # Construction du titre
  title_label = paste("Nombre de personne affect� au service '",secteur_str,"' dans les territoires francais\n du",
                      as.character.Date(date_min),
                      " au ",
                      as.character.Date(date_max))
  # Initialisation du graphique
  graph <- ggplot() +
    
    # Edition du titre
    ggtitle(label = title_label)+
    
    # # Edition des paramètres titre/legend
    theme(
      plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
      plot.subtitle = element_text(color = "#364167", hjust = 0.5),
      legend.position="bottom"
    )+
    # Edition des labels (ordonnées/abscisse)
    xlab("Date") + ylab("Nombre d'hospitalisation") +
    
    # Affichage des areas plot consernant les différents services
    geom_area(aes(x= as.Date(df_filtered$jour) ,y = secteur, color = secteur_str, fill = secteur_str), alpha=0.4)+ 
    # geom_area(aes(y = hosp, color = "total", fill = "total"), alpha=0.1)+ 
    # geom_area(aes(y = HospConv+SSR_USLD+autres, color = "conventionnelle", fill = "conventionnelle"), alpha=0.3)+
    # geom_area(aes(y = SSR_USLD+autres, color = "SSR_ou_USLD", fill = "SSR_ou_USLD"), alpha=0.4)+
    # geom_area(aes(y = autres, color = "autres", fill = "autres"), alpha=0.5)+
    
    # Paramétrage des couleurs des area plot et de la légende
    scale_color_manual("Hospitalisation", values=c(hospitalisation="#457b9d",
                                                   reanimation ="#e76f51",
                                                   conventionnelle = "#fcbf49",
                                                   SSR_USLD = "#588157" ,
                                                   autres = "#faedcd")) +  
    scale_fill_manual("Hospitalisation", values=c( hospitalisation="#457b9d",
                                                   reanimation ="#e76f51",
                                                   conventionnelle = "#fcbf49",
                                                   SSR_USLD = "#588157" ,
                                                   autres = "#faedcd"))
  
  return(graph)
  
}






