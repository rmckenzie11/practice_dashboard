## Load in libraries
library(shiny)
library(shinythemes)
library(tidyverse)
library(stringr)
library(gridExtra)
library(grid)
library(ggplotify)

## Set png(test)
png(bg = "wheat1")

## Load in tidy words by meeting
tidy_words <- readRDS("tidy_words.RDS")

## Load in sentiment plot by meeting
sent_plot_meetings <- readRDS("sent_plot_meetings.rds")

## Load in sentiment analysis of all comments
sent_all_comments <- readRDS("sent_all_comments.rds")

## Load in Topic Modelling
lda <- readRDS("LDA.rds")

## Funcion (fluidPage) that defines UI
ui <- fluidPage(
    
    ## ShinyThemes, remember to experiment later
    theme = shinytheme("cosmo"),
    
    # Application title
    titlePanel("Analysis of CACN Meetings, January 20 - March 9"),
    
    # Sidebar, MP Focus.  
    sidebarLayout(
        
        ## Only one panel, nice and simple
        sidebarPanel(
        
            h3("MP Focus"),
            
            ## Allow user to select an MP to see their specific analysis
            selectInput("select", "MP:", 
                        choices = unique(sent_all_comments$name), selected = "Mr. Richard Oliphant"),
            hr(),
            helpText("Data from ourcommons.ca."),
            
            ## 2ndd Output Table: the most frequent words, they used, remember to work on 
            h4("Most frequent words used by MP"),
            DT::dataTableOutput("mpTable"),
            
            ## 3rd Output, topics
            h4("Topics Mentioned Most by MP"),
            DT::dataTableOutput("mpTop")
            
        ),
        
        ## Main Panel: Overall Meeting 
        mainPanel(
            
            h3("Meeting Overview"),
            
            ## Tabs for each meeting
            tabsetPanel(type = "tabs",
                        tabPanel("Home",
                                 
                                 ## Overview text
                                 HTML(
                                     paste(
                                         p("There have been x words spoken during meetings of the Special Committee on Canada-China Relations. This web-app analyzes those meetings.")
                                     )
                                 ),
                                 img(src = "animtop.gif")
                                ),
                        tabPanel("Meeting 1",
                                 
                                 ## Overview text
                                 HTML(
                                     paste(
                                         p("There were 13,848 words spoken during the 1st meeting of the Special Committee on Canada-China Relations. This is an analysis conducted on the transcript of that meeting using the SentimentR framework, which evaluates the tone of a sentence as either positive or negative.")
                                     )
                                 ),
                                 
                                 ## First plot in each tab is sentiment density graph
                                 plotOutput("plot1"),
                                 
                                 ## Second Plot is Bar Graph of Words
                                 plotOutput("tplot1"),
                                 
                                 ## Third Plot is Topics!
                                 plotlyOutput("toplot1")),
                        
                        tabPanel("Meeting 3", 
                                 HTML(
                                    paste(
                                        p("There were 16,934 words spoken during the 3rd meeting of the Special Committee on Canada-China Relations. This is an analysis conducted on the transcript of that meeting using the SentimentR framework, which evaluates the tone of a sentence as either positive or negative.")
                                    )
                                ),
                                plotOutput("plot3"),
                                plotOutput("tplot3"),
                                plotOutput("toplot3")),

                        tabPanel("Meeting 4",
                                 HTML(
                                    paste(
                                        p("There were 17,107 words spoken during the 4th meeting of the Special Committee on Canada-China Relations. This is an analysis conducted on the transcript of that meeting using the SentimentR framework, which evaluates the tone of a sentence as either positive or negative.")
                                    )
                                ),
                                plotOutput("plot4"),
                                plotOutput("tplot4"),
                                plotOutput("toplot4")),
                        
                        tabPanel("Meeting 5", 
                                 HTML(
                                     paste(
                                         p("There were 18,416 words spoken during the 5th meeting of the Special Committee on Canada-China Relations. This is an analysis conducted on the transcript of that meeting using the SentimentR framework, which evaluates the tone of a sentence as either positive or negative.")
                                     )
                                 ),
                                 plotOutput("plot5"),
                                 plotOutput("tplot5"),
                                 plotOutput("tpplot5")),
    
                        tabPanel("Meeting 7", 
                                 HTML(
                                     paste(
                                         p("There were 24,596 words spoken during the 7th meeting of the Special Committee on Canada-China Relations. This is an analysis conducted on the transcript of that meeting using the SentimentR framework, which evaluates the tone of a sentence as either positive or negative.")
                                     )
                                 ),
                                 plotOutput("plot7"),
                                 plotOutput("tplot7"),
                                 plotOutput("toplot7")),
                        
                        tabPanel("Meeting 8", 
                                 HTML(
                                     paste(
                                         p("There were 24,532 words spoken during the 8th meeting of the Special Committee on Canada-China Relations. This is an analysis conducted on the transcript of that meeting using the SentimentR framework, which evaluates the tone of a sentence as either positive or negative.")
                                     )
                                 ),
                                 plotOutput("plot8"),
                                 plotOutput("tplot8"),
                                 plotOutput("toplot8")),
                        
                        tabPanel("LDA Topic Modelling",
                                 HTML(
                                     paste(
                                         p("This tab displayes Latent Dirichlet Allocation from Meetings 1-8. These were the words LDA determined most clearly identified as the 'topic' of the meeting.")
                                     )
                                 ),
                                 plotOutput("ldaplot"))
                        
            ),
            
        )
    )
)