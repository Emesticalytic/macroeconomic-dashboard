# =========================================================
# Macroeconomic Dashboard (2000–2023) - DEPLOYMENT VERSION
# GDP • Inflation • Unemployment • Interest Rates
# =========================================================

# ---------------------------------------------------------
# 1. PACKAGE LOADING
# ---------------------------------------------------------

library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)

# ---------------------------------------------------------
# 2. LOAD PRE-CLEANED DATA
# ---------------------------------------------------------

# Check if cached data exists, otherwise fetch fresh
if (file.exists("macro_data1_clean.rds")) {
  macro_data1_clean <- readRDS("macro_data1_clean.rds")
  cat("Loaded cached data\n")
} else {
  # Only load WDI if we need to fetch data
  library(WDI)
  
  countries <- c("US", "CN", "JP", "DE", "GB", "IN", "FR", "IT", "CA", "BR", "NG")
  
  indicators <- c(
    GDP = "NY.GDP.MKTP.CD",
    GDP_per_capita = "NY.GDP.PCAP.CD",
    Inflation = "FP.CPI.TOTL.ZG",
    Unemployment = "SL.UEM.TOTL.ZS",
    Exports = "NE.EXP.GNFS.ZS",
    Imports = "NE.IMP.GNFS.ZS"
  )
  
  macro_data <- WDI(
    country = countries,
    indicator = indicators,
    start = 2000,
    end = 2023,
    extra = FALSE,
    cache = NULL
  )
  
  macro_data1_clean <- macro_data %>%
    distinct() %>%
    drop_na() %>%
    mutate(across(where(is.character), trimws)) %>%
    group_by(country) %>%
    arrange(year) %>%
    mutate(
      log_GDP = log(GDP),
      gdp_growth = log_GDP - lag(log_GDP)
    ) %>%
    ungroup()
  
  saveRDS(macro_data1_clean, "macro_data1_clean.rds")
  cat("Fetched and saved fresh data\n")
}

cat("Data loaded - Rows:", nrow(macro_data1_clean), "\n")

# ---------------------------------------------------------
# 3. CONFIGURATION
# ---------------------------------------------------------

unique_countries <- sort(unique(macro_data1_clean$country))

country_colors <- c(
  "Brazil" = "#0072B2",
  "Canada" = "#D55E00",
  "China" = "#009E73",
  "France" = "#E69F00",
  "Germany" = "#56B4E9",
  "India" = "#F0E442",
  "Italy" = "#CC79A7",
  "Japan" = "#999999",
  "United Kingdom" = "#00D9A3",
  "United States" = "#CC0000"
)

# ---------------------------------------------------------
# 4. SHINY UI
# ---------------------------------------------------------

ui <- fluidPage(
  
  tags$head(
    tags$style(HTML("
      .main-title {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
      }
      h3 { color: #2c3e50; margin-top: 20px; }
      .well { border-radius: 8px; }
    "))
  ),
  
  div(class = "main-title",
      HTML("<h2 style='margin:0;'>🌍 Global Macroeconomic Dashboard</h2>"),
      HTML("<p style='margin:5px 0 0 0;'>Analyzing Economic Indicators Across 11 Major Economies (2000–2023)</p>")
  ),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "country",
        label = "Select Country(s):",
        choices = unique_countries,
        selected = unique_countries[1],
        multiple = TRUE
      ),
      width = 3
    ),
    
    mainPanel(
      wellPanel(
        style = "background-color: #f8f9fa;",
        HTML("<h4>📊 Dashboard Overview</h4>"),
        HTML("<p>Compare macroeconomic indicators across 11 major economies (2000-2023). 
              Select one or more countries to analyze GDP trends, growth patterns, inflation dynamics, 
              and trade relationships. Data sourced from World Bank Development Indicators.</p>")
      ),
      
      HTML("<h3>💰 GDP Trends</h3>"),
      HTML("<p><strong>What it shows:</strong> Total economic output measured in billions of USD. 
            Rising trends indicate economic expansion, while declines suggest contraction or recession.</p>"),
      plotOutput("gdpPlot", height = "350px"),
      
      HTML("<hr><h3>📈 GDP Growth Rates</h3>"),
      HTML("<p><strong>What it shows:</strong> Year-over-year percentage change in GDP (log-difference). 
            Positive values = economic expansion, negative values = recession. 
            Volatility indicates economic instability or structural changes.</p>"),
      plotOutput("growthPlot", height = "350px"),
      
      HTML("<hr><h3>🔴 Inflation & Unemployment</h3>"),
      HTML("<p><strong>What it shows:</strong> The relationship between price increases (inflation) and 
            joblessness (unemployment). The Phillips Curve suggests these often move inversely. 
            High inflation erodes purchasing power; high unemployment indicates economic slack.</p>"),
      plotOutput("inflationUnempPlot", height = "350px"),
      
      HTML("<hr><h3>🌐 Exports vs Imports (% of GDP)</h3>"),
      HTML("<p><strong>What it shows:</strong> Trade openness and competitiveness. 
            High exports indicate strong global demand for domestic goods. 
            When imports exceed exports, countries run trade deficits, potentially affecting currency values.</p>"),
      plotOutput("tradePlot", height = "350px"),
      
      HTML("<hr>"),
      wellPanel(
        style = "background-color: #e7f3ff;",
        HTML("<h4>📥 Export Your Analysis</h4>"),
        HTML("<p>Download the filtered data for your selected countries to perform further analysis 
              in Excel, Python, or other tools.</p>"),
        downloadButton("downloadData", "Download CSV Data")
      )
    )
  )
)

# ---------------------------------------------------------
# 5. SHINY SERVER
# ---------------------------------------------------------

server <- function(input, output, session) {
  
  filtered_data <- reactive({
    req(input$country)
    macro_data1_clean %>% filter(country %in% input$country)
  })
  
  output$gdpPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = year, y = GDP, colour = country)) +
      geom_line(linewidth = 1.2) +
      scale_y_continuous(labels = label_dollar(scale = 1e-9)) +
      scale_color_manual(values = country_colors) +
      labs(x = "Year", y = "GDP (Billions USD)", colour = "Country") +
      theme_minimal() +
      theme(legend.position = "bottom")
  })
  
  output$growthPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = year, y = gdp_growth, colour = country)) +
      geom_line(linewidth = 1.2) +
      scale_color_manual(values = country_colors) +
      labs(x = "Year", y = "GDP Growth (log-diff)", colour = "Country") +
      theme_minimal() +
      theme(legend.position = "bottom")
  })
  
  output$inflationUnempPlot <- renderPlot({
    df <- filtered_data() %>%
      pivot_longer(
        cols = c(Inflation, Unemployment),
        names_to = "Indicator",
        values_to = "Value"
      ) %>%
      mutate(Country_Indicator = paste(country, Indicator, sep = " - "))
    
    color_mapping <- setNames(
      rep(country_colors[df$country], each = 1),
      df$Country_Indicator
    )
    color_mapping <- color_mapping[!duplicated(names(color_mapping))]
    
    ggplot(df, aes(x = year, y = Value, colour = Country_Indicator, 
                   linetype = Indicator)) +
      geom_line(linewidth = 1.2) +
      scale_color_manual(values = color_mapping) +
      labs(y = "Rate (%)", x = "Year", 
           colour = "Country - Indicator", linetype = "Indicator") +
      theme_minimal() +
      theme(legend.position = "bottom")
  })
  
  output$tradePlot <- renderPlot({
    df <- filtered_data() %>%
      pivot_longer(
        cols = c(Exports, Imports),
        names_to = "Indicator",
        values_to = "Value"
      ) %>%
      mutate(Country_Indicator = paste(country, Indicator, sep = " - "))
    
    color_mapping <- setNames(
      rep(country_colors[df$country], each = 1),
      df$Country_Indicator
    )
    color_mapping <- color_mapping[!duplicated(names(color_mapping))]
    
    ggplot(df, aes(x = year, y = Value, colour = Country_Indicator, 
                   linetype = Indicator)) +
      geom_line(linewidth = 1.2) +
      scale_color_manual(values = color_mapping) +
      labs(y = "% of GDP", x = "Year", 
           colour = "Country - Indicator", linetype = "Indicator") +
      theme_minimal() +
      theme(legend.position = "bottom")
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("macroeconomic_data_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(filtered_data(), file, row.names = FALSE)
    }
  )
}

# ---------------------------------------------------------
# 6. RUN APPLICATION
# ---------------------------------------------------------

shinyApp(ui = ui, server = server)

rsconnect::deployApp()