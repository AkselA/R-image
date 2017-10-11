

img_display <- function(img, ...) {
	UseMethod("img_display")
}

img_display.image <- function(img, ...) {
	if (c_space(img) != "RGB") {
		img <- img_colorspace(img, c_out="RGB")
	}
	img_display.default(img, ...)
}

img_display.default <- function(img, bg=0:1, n.sq=16, interp=FALSE, ...) {
	if (length(bg) == 1) bg <- c(bg, bg)
	bg.m <- outer(1:n.sq, 1:n.sq, "+") %% 2
	bg.m[bg.m == 0] <- bg[1]
	bg.m[bg.m == 1] <- bg[2]
	grid::grid.raster(bg.m, interp=FALSE, 
	  height=unit(1, "npc"), width=unit(1, "npc"))
	grid::grid.raster(img, interp=interp, ...)
}

# data(oslo)
# img4 <- as.image(oslo)
# img4 <- img_colorspace(img4, c_out="LAB")
# summary(img4)

# img_display(img4)

# img4[,,1] <- tanh(img4[,,1]/90)
# img4[,,1] <- 100 * img4[,,1] / max(img4[,,1])
# summary(img4)

# dev.new()
# img_display(img4)
