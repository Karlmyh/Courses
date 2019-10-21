
get_data <- function(filename)
{
	data <- read.csv(filename,stringsAsFactors = FALSE)
	data <- data[,-1]
	tmpnames <- unlist(data[1,])
	names(data) <- tmpnames
	data <- data[-1,]
	data$salary <- as.numeric(data$salary)
	data$start_date <- as.Date(data$start_date)
	paste(data$name,"entered",data$dept,"at",as.character(data$start_date),sep=" ")
	data$comment <- paste(data$name,"entered",data$dept,"at",as.character(data$start_date),sep=" ")
	data$flag <- is.na(data$start_date)
	data
}

d1 <_ get_data("f:/input1.csv")
d2 <_ get_data("f:/input2.csv")

data <- rbind(d1,d2)

index <- duplicated(data$id)

data <- data[!index,]
