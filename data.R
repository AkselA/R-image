# example data
library(png)

img555 <- readPNG("~/Documents/R/data/img444.png")	

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
                    matrix(ncol=6)
                    
mode(colorchecker.hex)

colorchecker <- colorchecker.hex %>%
                col2rgb(alfa=TRUE) %>%
                array(dim=c(3, 6, 4)) %>%
                aperm(c(3, 2, 1)) / 255
                
colorchecker <- as.image(colorchecker, c_space="RGB")

colorchecker.hex.bak <- structure(c(
	"#735244", "#c29682", "#627a9d", "#576c43", "#8580b1", "#67bdaa",
	"#d67e2c", "#505ba6", "#c15a63", "#5e3c6c", "#9dbc40", "#e0a32e",
	"#383d96", "#469449", "#af363c", "#e7c71f", "#bb5695", "#0885a1",
	"#f3f3f2", "#c8c8c8", "#a0a0a0", "#7a7a79", "#555555", "#343434"),
	.Dim = c(4L, 6L))

