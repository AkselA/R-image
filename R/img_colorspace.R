
#' @export
img_colorspace <- function(img, ...) {
	UseMethod("img_colorspace")
}

#' @export
img_colorspace.image <- function(img, c_in, c_out="HSV") {
	if (missing(c_in)) c_in <- c_space(img)
	img_colorspace.default(img, c_in, c_out)
}

#' @import colorspace
#' @export
img_colorspace.default <- function(img, c_in="RGB", c_out="HSV") {
	
	img_dim <- dim(img)
	
	l1 <- c(img[,,1])
	l2 <- c(img[,,2])
	l3 <- c(img[,,3])
	
	if (img_dim[3] == 4) {
		l4 <- c(img[,,4])
	} else l4 <- NULL
	
	c_spaces <- c("RGB", "sRGB", "HSV", "HSL", "HLS", "XYZ",
	              "LAB", "LUV", "polarLAB", "polarLUV")
	c_in <- match.arg(c_in, c_spaces)
	c_out <- match.arg(c_out, c_spaces)
	
	if (c_in == "HSL") c_in <- "HLS"
	if (c_out == "HSL") c_out <- "HLS"
	
	im_in <-  match.fun(c_in)(l1, l2, l3)
	
	if (c_in != "RGB") im_in <- as(im_in, "RGB")
	
	im_out <-  as(im_in, c_out)@coords
	
	im_out <- array(c(im_out[,1], im_out[,2], im_out[,3], l4), dim=img_dim)
	
	if (c_out == "RGB") {
		im_out[im_out > 1] <- 1
		im_out[im_out < 0] <- 0
	}
	
	as.image(im_out, c_space=c_out)
}

