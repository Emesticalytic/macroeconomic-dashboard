# Global Macroeconomic Analysis Dashboard (2000–2023)

[![R](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)](https://www.r-project.org/)
[![Shiny](https://img.shields.io/badge/Shiny-Dashboard-blue)](https://shiny.rstudio.com/)
[![World Bank Data](https://img.shields.io/badge/Data-World%20Bank%20WDI-orange)](https://datacatalog.worldbank.org/)

## 📊 Project Overview

An interactive data science project analyzing macroeconomic indicators across 11 major economies from 2000 to 2023. This full-stack Shiny application retrieves, cleans, and visualizes World Bank Development Indicators to provide actionable insights for business strategy, investment planning, and economic forecasting.

**Live Dashboard:** [View Demo](https://ememakpan.shinyapps.io/macroeconomic-dashboard/) | **Data Source:** World Bank WDI API

---

## 🎯 Key Features

- **Real-time Data Integration:** Automated retrieval from World Bank WDI API
- **Multi-Country Comparison:** Analyze 11 major economies simultaneously
- **Interactive Visualizations:** Dynamic filtering and country selection
- **Comprehensive Metrics:** GDP, inflation, unemployment, and trade indicators
- **Professional Design:** Clean, responsive UI with custom color schemes
- **Export Functionality:** Download filtered data as CSV

---

## 🌍 Countries Analyzed

**Americas:** United States, Canada, Brazil  
**Europe:** Germany, United Kingdom, France, Italy  
**Asia-Pacific:** China, Japan, India  
**Africa:** Nigeria

---

## 📈 Economic Indicators

| Indicator | WDI Code | Description |
|-----------|----------|-------------|
| **GDP** | NY.GDP.MKTP.CD | Gross Domestic Product (current US$) |
| **GDP per Capita** | NY.GDP.PCAP.CD | GDP divided by population |
| **Inflation** | FP.CPI.TOTL.ZG | Consumer Price Index annual % change |
| **Unemployment** | SL.UEM.TOTL.ZS | Unemployment rate (% of labor force) |
| **Exports** | NE.EXP.GNFS.ZS | Exports of goods and services (% of GDP) |
| **Imports** | NE.IMP.GNFS.ZS | Imports of goods and services (% of GDP) |

---

## 🔍 Key Insights

### 1. GDP Growth Patterns

**Emerging Markets (High Growth)**
- China & India: >5% annual growth, rapid market expansion
- Brazil: 2–4% growth with moderate volatility

**Developed Economies (Stable Growth)**
- USA, Germany, Japan: 1–3% growth, predictable markets
- France, Italy: Slow growth, mature markets

**Business Implication:** Emerging markets offer high expansion potential; developed markets provide stability for long-term planning.

### 2. Inflation Dynamics

**High Volatility:** Brazil shows significant inflation fluctuations affecting purchasing power  
**Stable Environment:** USA, Germany, Japan maintain low/moderate inflation  
**Rising Trend:** India and China experiencing gradual inflation increases

**Business Implication:** High-inflation markets require dynamic pricing strategies and currency hedging; stable markets support predictable cost structures.

### 3. Labor Market Conditions

**Tight Markets (Low Unemployment):**
- Germany, Japan, USA: <6% unemployment
- Competitive talent acquisition, wage pressure

**Slack Markets (High Unemployment):**
- Brazil: 10–12%, India: 7–10%
- Easier hiring, lower consumption

**Business Implication:** Workforce planning and compensation strategies must align with local labor market conditions.

### 4. Trade Balance Analysis

**Export Leaders:** China, Germany, USA demonstrate strong global competitiveness  
**Import Dependency:** Brazil shows periods of high import reliance  
**Trade Volatility:** Affects exchange rates and GDP stability

**Business Implication:** Export-driven economies offer B2B opportunities; import-dependent markets present supply chain investment potential.

---

## 🛠️ Technical Stack

```r
# Core Libraries
library(shiny)       # Interactive web applications
library(WDI)         # World Bank data retrieval
library(dplyr)       # Data manipulation
library(tidyr)       # Data tidying
library(ggplot2)     # Data visualization
library(scales)      # Number formatting
library(bslib)       # UI theming
```

---

## 📁 Project Structure

```
macroeconomic-dashboard/
├── app.R                    # Main Shiny application
├── README.md               # Project documentation
├── data/
│   └── macro_data_clean.rds # Cleaned dataset (cached)
├── scripts/
│   ├── data_retrieval.R    # WDI API calls
│   └── data_cleaning.R     # Data preprocessing
└── images/
    └── dashboard_preview.png
```

---

## 🚀 Installation & Usage

### Prerequisites
- R (≥ 4.0.0)
- RStudio (recommended)

### Setup

```r
# Install required packages
install.packages(c("shiny", "WDI", "dplyr", "tidyr", 
                   "ggplot2", "scales", "bslib"))

# Clone repository
git clone https://github.com/yourusername/macroeconomic-dashboard.git

# Run application
setwd("macroeconomic-dashboard")
shiny::runApp()
```

### Quick Start

1. Select countries from dropdown menu
2. Compare GDP trends across time periods
3. Analyze growth rates and economic cycles
4. Examine inflation-unemployment relationships
5. Evaluate trade balance dynamics
6. Export filtered data as CSV

---

## 📊 Dashboard Visualizations

### 1. GDP Trends
Line chart displaying absolute GDP values (in billions USD) with customizable country selection and time-series tracking.

### 2. GDP Growth Rates
Log-difference growth rates showing economic expansion/contraction cycles and volatility patterns.

### 3. Inflation & Unemployment
Dual-metric visualization revealing Phillips curve relationships and labor market dynamics.

### 4. Trade Balance
Exports vs. imports comparison highlighting trade competitiveness and external sector health.

---

## 💼 Business Applications

**Investment Strategy**
- Identify high-growth markets for capital allocation
- Assess macroeconomic stability for risk management
- Forecast demand trends based on GDP trajectories

**Market Entry Planning**
- Evaluate market size and growth potential
- Understand labor cost structures
- Analyze trade openness and competitiveness

**Operational Planning**
- Anticipate inflation impacts on costs
- Plan workforce strategies based on unemployment
- Hedge against currency and trade risks

**Strategic Forecasting**
- Model scenario-based economic outcomes
- Benchmark performance against economic cycles
- Optimize supply chain and production locations

---

## 📚 Data Methodology

### Data Collection
- **Source:** World Bank World Development Indicators (WDI) API
- **Time Period:** 2000–2023 (24 years)
- **Frequency:** Annual observations
- **Coverage:** 11 countries × 6 indicators = 66 time series

### Data Cleaning Pipeline

1. **Duplicate Removal:** Eliminate redundant observations
2. **Missing Value Treatment:** Drop incomplete records
3. **Whitespace Normalization:** Trim character fields
4. **Feature Engineering:** Calculate log GDP and growth rates
5. **Validation:** Verify data integrity and completeness

### Quality Assurance
- Minimal missing values post-cleaning
- Consistent country naming conventions
- Temporal ordering verification
- Outlier detection and handling

---

## 🔮 Future Enhancements

- [ ] Add forecasting models (ARIMA, Prophet)
- [ ] Implement real-time data updates
- [ ] Include additional indicators (FDI, trade balances)
- [ ] Add country-level regression analysis
- [ ] Export functionality (PDF reports, CSV data)

---

## 📖 References

- World Bank. (2024). *World Development Indicators*. Retrieved from https://datacatalog.worldbank.org/
- International Monetary Fund. (2024). *World Economic Outlook Database*.
- OECD. (2024). *Economic Outlook and Key Indicators*.

---

## 👤 Author

**Emem Akpan**  
Economist|Data Scientist | Business Analyst | (R



## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- World Bank for providing open-access economic data
- R Shiny community for excellent documentation
- Contributors to the WDI, dplyr, and ggplot2 packages

---

**⭐ If you find this project useful, please consider giving it a star!**
