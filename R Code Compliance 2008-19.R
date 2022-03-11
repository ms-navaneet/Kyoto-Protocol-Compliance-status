# List of packages for session
.packages = c("ggplot2", "dplyr", "readr","plotly")
# Install CRAN packages (if not already installed)
.inst <- .packages %in% installed.packages()
if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])

library(ggplot2)
library(plotly)
library(dplyr)
library(readr)

cc_data <- read_csv("Kyoto Protocol Compliance.csv",  na = "N/A")
df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv")

combined <- merge(x=cc_data, y=df, by.x = "Country", by.y = "COUNTRY", all = FALSE) %>% 
  select(Country,CODE,`Difference in First Target Period`,`Difference in Second Target Period`)

g <- list(
  showframe = FALSE,
  showcoastlines = TRUE,
  projection = list(type = 'Mercator')
)
#Map for 2008-12 Period

cc_map2008 <- plot_geo(combined) %>% 
  add_trace(z = ~`Difference in First Target Period`, 
            color = ~`Difference in First Target Period`, colors = "OrRd",
            text = ~Country, locations = ~CODE) %>% 
  colorbar(title = 'Difference\nfrom Target (%) ') %>% 
  layout( title = list(text='Compliance to Kyoto Protocol\n2008-12', y = 0.95, x = 0.5),
          geo=g)


cc_map2008%>% add_annotations(showarrow= FALSE,
                          text = "US failed\nto Ratify",
                          x = 0.1, y = 0.5,
                          xanchor='left',
                          xref="paper",
                          yref="paper")

#Map for 2012-19 Period

cc_map2012 <- plot_geo(combined) %>% 
  add_trace(z = ~`Difference in Second Target Period`, 
            color = ~`Difference in Second Target Period`, colors = "OrRd",
            text = ~Country, locations = ~CODE) %>% 
  colorbar(title = 'Difference\nfrom Target (%) ') %>% 
  layout( title = list(text='Compliance to Kyoto Protocol\n2012-19', y = 0.95, x = 0.5),
          geo=g)

cc_map2012 %>% add_annotations(showarrow= FALSE,
                           text = "US,Canada\nJapan, Russia\nNew Zealand failed\nto Ratify",
                           x = 0.05, y = 0.3,
                           xanchor='left',
                           xref="paper",
                           yref="paper")

#Map for 2012-19 Period of Europe
g1 <- list(
  scope = 'europe',
  showframe = FALSE,
  showcoastlines = TRUE,
  projection = list(type = 'Mercator')
)

cc_europe <- plot_geo(combined) %>% 
  add_trace(z = ~`Difference in Second Target Period`, 
            color = ~`Difference in Second Target Period`, colors = "OrRd",
            text = ~Country, locations = ~CODE) %>% 
  colorbar(title = 'Difference\nfrom Target (%) ') %>% 
  layout( title = list(text='Compliance to Kyoto Protocol: 2012-19 (Europe)', y = 0.05),
          geo=g1)

cc_europe 
