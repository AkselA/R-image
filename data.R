# example data
library(png)

img444 <- readPNG("~/Documents/R/data/img444.png")	

img544 <- readPNG("~/Documents/R/data/img544.png")	

palette <- readPNG("~/Documents/R/data/palette.png")	

oslo <- readPNG("~/Documents/R/data/oslo.png")	

mandrill <- readPNG("~/Documents/R/data/mandrill.png")	

flowers <- readPNG("~/Documents/R/data/flowers.png")	

macaws <- readPNG("~/Documents/R/data/macaws.png")	

house <- readPNG("~/Documents/R/data/house.png")	


library(rvest)

colorchecker.hex <- "https://en.wikipedia.org/wiki/ColorChecker" %>%
                    read_html() %>%
                    html_nodes("td:nth-child(5)") %>%
                    html_text() %>%
                    matrix(ncol=4) %>%
                    t()
                    
colorchecker <- as.image(colorchecker.hex.bak)

colorchecker.hex.bak <- structure(c(
	"#735244", "#d67e2c", "#383d96", "#f3f3f2", "#c29682", 
	"#505ba6", "#469449", "#c8c8c8", "#627a9d", "#c15a63", "#af363c", 
	"#a0a0a0", "#576c43", "#5e3c6c", "#e7c71f", "#7a7a79", "#8580b1", 
	"#9dbc40", "#bb5695", "#555555", "#67bdaa", "#e0a32e", "#0885a1", 
	"#343434"), .Dim = c(4L, 6L))

