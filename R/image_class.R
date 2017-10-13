#' @export
fitrange <- function(W, lower=0, upper=1) {
	if(lower>upper) warning("upper bound must be strictly larger than lower bound")
	newrange <- upper - lower
	oldrange <- max(W, na.rm=TRUE) - min(W, na.rm=TRUE)
	(W - min(W, na.rm=TRUE)) * (newrange/oldrange) + lower
}

#' @export
is.image <- function(object) {
	inherits(object, "image")
}

#' @export
c_space <- function(x) {
	attr(x, "c_space")
}

#' @export
"c_space<-" <- function(x, value) {
	    attr(x, "c_space") <- value
	x
}

#' @export
as.image <- function(object, ...) {
	UseMethod("as.image")
}

#' @export
as.image.matrix <- function(object, bwscale=FALSE) {
	dim <- dim(object)
	if (mode(object) != "character") {
		zer <- matrix(rep(0, prod(dim)), dim[1])
		if (bwscale) object <- fitrange(object, 0, 1)
		img <- img_stack(zer, zer, object, c_space="HSV")
	} else {
        mat <- col2rgb(object, alpha=TRUE)
		if (min(mat[4,]) == 255) {
			arr <- array(c(mat[1,], mat[2,], mat[3,]), dim=c(dim, 3))
		} else {
			arr <- array(c(mat[1,], mat[2,], mat[3,], mat[4, ]), dim=c(dim, 4))
		}
		img <- "c_space<-"(arr, "RGB") / 255
	}
	img
}

#' @export
as.image.default <- function(object, c_space="RGB") {
	d <- dim(object)
	if (length(d) == 3 & d[3] %in% 3:4) {
		class(object) <- c("image", "array")
	} else {
		stop("Cannot be coerced into class 'image'")
	}
	if (is.null(c_space(object))) c_space(object) <- c_space
	object
}

#' @export
summary.image <- function(img, ...) {
	summ <- apply(img, 3, function(x) summary(c(x), ...))
	l <- list(summ, dim(img), c_space(img))
	names(l) <- c("channel summaries",
	              "dimensions",
	              "color space")
	l
}

#' @export
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

