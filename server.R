library(ggplot2)
shinyServer(
        function(input, output) {
                
     
                
                convA <- renderText({               

                        actionsA <- as.numeric(input$sliderActionsA)
                        goalsA <- as.numeric(input$sliderGoalsA)
                        
                        actionsB <- as.numeric(input$sliderActionsB)
                        goalsB <- as.numeric(input$sliderGoalsB)
                        
                         convA <- goalsA/actionsA
                        se2A <- convA*(1-convA)/actionsA
                        
                        convB <- goalsB/actionsB
                        se2B <- convB*(1-convB)/actionsB
                        
                        seBoth <- sqrt(se2A + se2B)
                        
                        pointEstimate <- convA - convB
                        
                        sds <- abs(pointEstimate)/seBoth
                        
                        pval <- pnorm(sds)
                        
                        pval
                        
                        if (pval >= 0.99){
                                ("99% sure")
                        } else if (pval >= 0.95){
                                ("95% sure")
                        } else if (pval >= 0.9){
                                ("90% sure")
                        } else if (pval >= 0.8){
                                ("not very sure")
                        } else {
                                "not at all sure"
                                
                        }

                        })
                
                output$text1 <- convA
                
                output$conv1 <- renderText({
                        
                        actionsA <- as.numeric(input$sliderActionsA)
                        goalsA <- as.numeric(input$sliderGoalsA)                        
#                         
                        convA <- goalsA/actionsA
                        se2A <- convA*(1-convA)/actionsA
                        
                        
                        maxAp <- (convA + sqrt(se2A))*100
                       
                        
                        minAp <- (convA - sqrt(se2A))*100
                        
                        paste0(round(minAp, 2), " - ", round(maxAp, 2), "%")
                        
                })
                
                output$conv2 <- renderText({
                                                
                        actionsB <- as.numeric(input$sliderActionsB)
                        goalsB <- as.numeric(input$sliderGoalsB)
                                                
                        convB <- goalsB/actionsB
                        se2B <- convB*(1-convB)/actionsB
                                                
                        
                        maxBp <- (convB + sqrt(se2B))*100
                        
                        
                        minBp <- (convB - sqrt(se2B))*100
                        
                        paste0(round(minBp, 2), " - ", round(maxBp, 2), "%")
                })
                        
                
                
                #output$slideMax <- renderText({as.numeric(input$num)})
                
                output$sliderAA <- renderUI({
                        sliderInput("sliderActionsA", h5("Total Actions", p("(Impressions/Opens/Visits etc)", style = "font-weight : normal; font-size: 12px")), min=0, max=input$num, value=50)
                })
                
                output$sliderGA <- renderUI({
                        sliderInput("sliderGoalsA", label = h5("Goal Actions", p("(Ad clicks/Clicks/Conversions etc)", style = "font-weight : normal; font-size: 12px")), min = 0, max = input$num, value = 1)
                })
                
                output$sliderAB <- renderUI({
                        sliderInput("sliderActionsB", label = h5("Total Actions", p("(Impressions/Opens/Visits etc)", style = "font-weight : normal; font-size: 12px")), min = 0, max = input$num, value = 50)
                })
                
                output$sliderGB <- renderUI({
                        sliderInput("sliderGoalsB", label = h5("Goal Actions", p("(Ad clicks/Clicks/Conversions etc)", style = "font-weight : normal; font-size: 12px")), min = 0, max = input$num, value = 1)
                })
                
                
                
                
                output$newGG <- renderPlot({
                        

                        actionsA <- as.numeric(input$sliderActionsA)
                        goalsA <- as.numeric(input$sliderGoalsA)
                        
                        actionsB <- as.numeric(input$sliderActionsB)
                        goalsB <- as.numeric(input$sliderGoalsB)
                        
                        convA <- goalsA/actionsA
                        se2A <- convA*(1-convA)/actionsA
                        
                        convB <- goalsB/actionsB
                        se2B <- convB*(1-convB)/actionsB
                        
                        maxA <<- convA + sqrt(se2A)
                        maxB <<- convB + sqrt(se2B)
                        
                        minA <<- convA - sqrt(se2A)
                        minB <<- convB - sqrt(se2B)
                                
                        
                        
                        df <- data.frame(
                                Creative = c("Creative A", "Creative B"),
                                Conversion = c(convA, convB)
                                
                        )
                        
                        
                        
                        limits <- aes(ymax = c(maxA, maxB), 
                                       ymin= c(minA, minB))
                        
                        p <- ggplot(df, aes(fill=Creative, y=Conversion, x=Creative))
                        p + geom_bar(position="dodge", stat="identity", width = 0.5) + geom_errorbar(limits, width=0.2) +
                                guides(fill=FALSE)
                        
                })
                
                
                ## numeric
                
                convN <- renderText({               
                        
                        actionsA <- as.numeric(input$numActionsA)
                        goalsA <- as.numeric(input$numGoalsA)
                        
                        actionsB <- as.numeric(input$numActionsB)
                        goalsB <- as.numeric(input$numGoalsB)
                        
                        convA <- goalsA/actionsA
                        se2A <- convA*(1-convA)/actionsA
                        
                        convB <- goalsB/actionsB
                        se2B <- convB*(1-convB)/actionsB
                        
                        seBoth <- sqrt(se2A + se2B)
                        
                        pointEstimate <- convA - convB
                        
                        sds <- abs(pointEstimate)/seBoth
                        
                        pval <- pnorm(sds)
                        
                        pval
                        
                        if (pval >= 0.99){
                                ("99% sure")
                        } else if (pval >= 0.95){
                                ("95% sure")
                        } else if (pval >= 0.9){
                                ("90% sure")
                        } else if (pval >= 0.8){
                                ("not very sure")
                        } else {
                                "not at all sure"
                                
                        }
                        
                })
                
                output$text12 <- convN
                
                output$conv12 <- renderText({
                        
                        actionsA <- as.numeric(input$numActionsA)
                        goalsA <- as.numeric(input$numGoalsA)                        
                        
                        convA <- goalsA/actionsA
                        se2A <- convA*(1-convA)/actionsA
                        
                        
                        maxAp <- (convA + sqrt(se2A))*100
                        
                        
                        minAp <- (convA - sqrt(se2A))*100
                        
                        paste0(round(minAp, 2), " - ", round(maxAp, 2), "%")
                        
                })
                
                output$conv22 <- renderText({
                        
                        actionsB <- as.numeric(input$numActionsB)
                        goalsB <- as.numeric(input$numGoalsB)
                        
                        convB <- goalsB/actionsB
                        se2B <- convB*(1-convB)/actionsB
                        
                        
                        maxBp <- (convB + sqrt(se2B))*100
                        
                        
                        minBp <- (convB - sqrt(se2B))*100
                        
                        paste0(round(minBp, 2), " - ", round(maxBp, 2), "%")
                })
                
                
                
                #output$slideMax <- renderText({as.numeric(input$num)})
                
                             
                
                
                output$newGG2 <- renderPlot({
                        
                        
                        actionsA <- as.numeric(input$numActionsA)
                        goalsA <- as.numeric(input$numGoalsA)
                        
                        actionsB <- as.numeric(input$numActionsB)
                        goalsB <- as.numeric(input$numGoalsB)
                        
                        convA <- goalsA/actionsA
                        se2A <- convA*(1-convA)/actionsA
                        
                        convB <- goalsB/actionsB
                        se2B <- convB*(1-convB)/actionsB
                        
                        maxA2 <<- convA + sqrt(se2A)
                        maxB2 <<- convB + sqrt(se2B)
                        
                        minA2 <<- convA - sqrt(se2A)
                        minB2 <<- convB - sqrt(se2B)
                        
                        
                        
                        df <- data.frame(
                                Creative = c("Creative A", "Creative B"),
                                Conversion = c(convA, convB)
                                
                        )
                        
                        
                        
                        limits <- aes(ymax = c(maxA2, maxB2), 
                                      ymin= c(minA2, minB2))
                        
                        p <- ggplot(df, aes(fill=Creative, y=Conversion, x=Creative))
                        p + geom_bar(position="dodge", stat="identity", width = 0.5) + geom_errorbar(limits, width=0.2) +
                                guides(fill=FALSE)
                        
                })
                
        }
)


#devtools::install_github('rstudio/shinyapps')

#library(shinyapps)

#shinyapps::setAccountInfo(name='maximusdecimusmeridius', token='53B82BE92114233C77BE26012B14059C', secret='KqlaPKhIp8MWM324sS4yxpZz0ZKBMecP92oKTQ3+')

#deployApp()
#shinyapps::setAccountInfo(name='maximusdecimusmeridius', token='53B82BE92114233C77BE26012B14059C', secret='KqlaPKhIp8MWM324sS4yxpZz0ZKBMecP92oKTQ3+')