library(shiny)
library(plot3D)
library(rgl)

# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  # Reactive expression to generate the requested distribution. This is 
  # called whenever the inputs change. The renderers defined 
  # below then all use the value computed from this expression
  data <- reactive({  
    r = input$rows
    c = input$cols
    names = as.character(c(1:r))
    data.frame(matrix(rnorm(r*c), r, c), row.names=names)
  })
  
  formula <- reactive({
    switch(input$distance_type,
           man = "manhattan",
           euc = "euclidean",
           max = "maximum"
      )
  })
  
  # Generate an HTML table view of the data
  output$table <- renderTable({
    data.frame(x=data())
  })
  output$summary <- renderTable({
    summary(data())
  })
  output$distance <- renderTable({
  #  as.matrix(dist(x=data(), method="euclidean"))
    as.matrix(dist(x=data(), method=formula()))
  })
  output$plot <- renderPlot({
    
    xx = data()[,1]
    yy = data()[,2]
    zz = data()[,3]
    tt = row.names(data)

    scatter3D(z = zz, x = xx, y = yy, pch = 18, cex = 2, 
              theta = 20, phi = 20, ticktype = "detailed",
              xlab = "L", ylab = "A", zlab = "B",
              revolutions = 3,
              labels = tt,
              main = "LAB Neighbors")
    
    
   #scatter3d(data()[,1], data()[,2], data()[,3])
  })
})