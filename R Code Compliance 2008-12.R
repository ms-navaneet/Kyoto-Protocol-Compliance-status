# List of packages for session
.packages = c("ggplot2", "dplyr", "readr","plotly")
# Install CRAN packages (if not already installed)
.inst <- .packages %in% installed.packages()
if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])

library(ggplot2)
library(plotly)
library(dplyr)
library(readr)

cc_data <- read_csv("Kyoto Protocol Compliance.csv")
df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv")

combined <- merge(x=cc_data, y=df, by.x = "Country", by.y = "COUNTRY", all = FALSE) %>% 
  select(Country,CODE,`Difference in First Target Period`,`Difference in Second Target Period`)

g <- list(
  showframe = FALSE,
  showcoastlines = TRUE,
  projection = list(type = 'Mercator')
)

cc_map <- plot_geo(combined) %>% 
  add_trace(z = ~`Difference in First Target Period`, 
            color = ~`Difference in First Target Period`, colors = "OrRd",
            text = ~Country, locations = ~CODE) %>% 
  colorbar(title = 'Difference\nfrom Target °C ') %>% 
  layout( title = list(text='Compliance to Kyoto Protocol\n2008-12', y = 0.95, x = 0.5),
          geo=g)


cc_map%>% add_annotations(
                          text = "US failed\nto Ratify",
                          arrowhead = 4,
                          arrowcolor='blue',
                          x = 0.2, y = 0.63, ax = -30,
                          ay = 60)


