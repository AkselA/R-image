
is.image <- function(object) {
	inherits(object, "image")
}

c_space <- function(x) {
	attr(x, "c_space")
}

"c_space<-" <- function(x, value) {
	    attr(x, "c_space") <- value
	x
}

as.image <- function(object, c_space="RGB") {
	d <- dim(object)
	if (length(d) == 3 & d[3] >= 3) {
		class(object) <- c("image", "array")
	} else {
		stop("Cannot be coerced into class 'image'")
	}
	if (is.null(c_space(object))) c_space(object) <- c_space
	object
}

summary.image <- function(img, ...) {
	summ <- apply(img, 3, function(x) summary(c(x), ...))
	l <- list(summ, dim(img), c_space(img))
	names(l) <- c("channel summaries",
	              "dimensions",
	              "color space")
	l
}

img_stack <- function(l1, l2, l3, l4=NULL, c_space="RGB") {
	d1 <- dim(l1)
	
	equal_dims <- all(d1 == dim(l2) & 
	                  d1 == dim(l3) & ifelse(is.null(l4), TRUE,
	                  d1 == dim(l4)))
	
	if (!equal_dims) stop("matrices need to have identical dimensions")
	
	d <- c(d1, 3 + length(l4[1]))
	img <- array(c(l1, l2, l3, l4), dim=d)
	as.image(object=img, c_space=c_space)
}

