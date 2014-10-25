library(shiny)
#deployApp(appName="ABtest")
shinyUI(fluidPage(
     
        ### Header Section
        
        titlePanel( h1(span("A ", style = "color:salmon"), "/" , span("B ", style = "color:green"), "Tester"), windowTitle = "Shiny A/B Tester" ),
        br(),
        h5("A simple tool to quickly check for statistical significance in performance difference between two creatives.",
        br(), 
        "The test uses a t-statistic hypothesis test to determine difference, and then gives a confidence",
        br(),
        "interval for both creatives. All tests are at 95% significance level unless otherwise stated."
        ,br(), br(),
        "The application is built in Twitter Bootstrap using the Shiny framework for R, with the GGplot2 package for creating plots."),
        
        br(), 
        
        p(span("INSTRUCTIONS:", style = "font-weight: bold"), br(), 
          
"Enter the total actions and total conversion actions for two creatives. 
          For example, if you want to compare clickthrough rate for two ads, ",br(),
          "you would enter the number of impressions and number of
          clicks for each ad. Under the 'Results' section you can see the likelihood of ", br(), " there being a difference in performance between
          the two ads.", br(), br(), " The plot shows the conversion rates along with the 95% confidence interval for each creative."),
        
        p("If you choose to input the data using a slider you can set the slider maximum in the 'Slider Max' input field.
         If the values are too large for a", br(), " slider to be practical, select 'Numeric' from the 'Choose input type' drop down to enter
        the values manually."),

h4("tl;dr Enter clicks/impressions for two ads below and compare their performance."),
        
        br(),
        

        
       ### Body
       
       selectInput(
                "inputType", "Choose input type",
                c(Slider = "slider",
                Numerical = "hist")),
       
       ### Sliders
      
       
       conditionalPanel(
               condition = "input.inputType == 'slider'",
               br(), 
               
               
               fluidRow(
                       
                       column(3,
                              
                              h3("Creative", span("A", style = "color:salmon")),
                              
                              uiOutput("sliderAA"),                           
                              br(), 
                              uiOutput("sliderGA")
                              
                              , style = "padding: 19px; background-color: #f5f5f5; border: 1px solid #e3e3e3"

                       ), 
                       
                       
                       column(3,
                              
                              h3("Creative", span("B", style = "color:green")),
                              
                              uiOutput("sliderAB"), 
                              br(), 
                              uiOutput("sliderGB")
                             
                              , style = "padding: 19px; background-color: #f5f5f5; border: 1px solid #e3e3e3"
                             #, br(), br(), br()
                              
                       )
                       
               ), # Fluidrow close
              
               numericInput("num", label = h5("Slider Max"), value = 100),
               br(),br(),
               
               ## Results Section ##
               h2("Results"),
               
               fluidRow(
                       column(3,
                              br(),
                                                            
                              h5("You are", span(textOutput('text1', container = span), style = " font-weight: bold; color: blue"),
                                "there is a difference in performance."),
                              
                               p(span("Creative A", style = "color:salmon; font-weight: bold"), "will have a conversion rate between",
                                 span(textOutput('conv1', container = span), style = " font-weight: bold; color: red")),
                              
                              p(span("Creative B", style = "color:green; font-weight: bold"), "will have a conversion rate between",
                                span(textOutput('conv2', container = span), style = " font-weight: bold; color: red"))
                       ),
                       
                       
                       
                       column(3,
                              plotOutput('newGG')
                              
                       )
                       
                       
                       
               ) # fluidrow close
               
       ), # first conditional close
       
       
     
       
            
        ### Numeric
        conditionalPanel(
                       condition = "input.inputType == 'hist'",
                       br(),
                       fluidRow(
                               
                               column(3,
                                      
                                      h3("Creative", span("A", style = "color:salmon")),
                                      
                                      numericInput("numActionsA", label = h5("Total Actions", p("(Impressions/Opens/Visits etc)", style = "font-weight : normal; font-size: 12px")), value = 100),
                                      numericInput("numGoalsA", label = h5("Goal Actions", p("(Ad clicks/Clicks/Conversions etc)", style = "font-weight : normal; font-size: 12px")), value = 1)
                                      
                                      
                                      , style = "padding: 19px; background-color: #f5f5f5; border: 1px solid #e3e3e3"
                                      
                               ), 
                               
                               
                               column(3,
                                      
                                      h3("Creative", span("B", style = "color:green")),
                                      
                                      numericInput("numActionsB", label = h5("Total Actions", p("(Impressions/Opens/Visits etc)", style = "font-weight : normal; font-size: 12px")), value = 100),
                                      numericInput("numGoalsB", label = h5("Goal Actions", p("(Ad clicks/Clicks/Conversions etc)", style = "font-weight : normal; font-size: 12px")), value = 1)
                                      
                                      
                                      , style = "padding: 19px; background-color: #f5f5f5; border: 1px solid #e3e3e3"
                                      #, br(), br(), br()
                                      
                               )
                               
                       ), # Fluidrow close
                       
                                              
                       ## Results Section ##
                       h2("Results"),
                       
                       fluidRow(
                               column(3,
                                      br(),
                                      
                                      h5("You are", span(textOutput('text12', container = span), style = " font-weight: bold; color: blue"),
                                         "there is a difference in performance."),
                                      
                                      p(span("Creative A", style = "color:salmon; font-weight: bold"), "will have a conversion rate between",
                                        span(textOutput('conv12', container = span), style = " font-weight: bold; color: red")),
                                      
                                      p(span("Creative B", style = "color:green; font-weight: bold"), "will have a conversion rate between",
                                        span(textOutput('conv22', container = span), style = " font-weight: bold; color: red"))
                               ),
                               
                               
                               
                               column(3,
                                      plotOutput('newGG2')
                                      
                               )
                               
                               
                               
                       ) # fluidrow close
               
       ) # second conditional close
              


        
       
       
        


)#Fluidpage close


)# shiny close        


# How do I calculate confidence intervals and difference? Really should know this :P
# http://www.r-tutor.com/elementary-statistics/interval-estimation/interval-estimate-population-proportion
# Now figure out how to do a UI switch to input fields

# Now add plot on the side http://docs.ggplot2.org/0.9.3.1/geom_errorbar.html
# then just get the input in server.R and do the calculations and pass back in


#str(prop.test(33,100))

#prop.test(10,500)$conf.int

# If I want to do stuff about population size
# http://www.r-tutor.com/elementary-statistics/interval-estimation/sampling-size-population-proportion