setwd("/Users/juliema/Desktop/trees/")
library(ape)

data <-read.delim(file="frs.bp150_nt1000.EXTRA.0240.brlens.csv", header=F, sep=":")
data <-read.delim(file="frs.bp150_nt1000.EXTRA.0241.brlens.csv", header=F, sep=":")
data1 <-read.delim(file="frs.bp150_nt1000.EXTRA.0240.brlens.csv", header=F, sep=":")
boxplot(data[,2], data1[,2])



x <-1:285

####files <-lapply(1:285, function(x){paste0("frs.bp150_nt1000.EXTRA.0", x, ".tre")})
filelist <-dir(pattern = "frs.bp150_nt1000.EXTRA.*.brlens.csv")


ldf <-list()
for (i  in 1:length(filelist)){
	ldf[[i]]<-read.delim(filelist[i], header=F, sep=":")
	
}

trelist <-dir(pattern = "frs.bp150_nt1000.EXTRA.*.tre")
trees <-list()
for (i in 1:length(trelist)) {
	trees[[i]]<-read.tree(trelist[i])	
}


par(mfrow=c(4,15))
for (i  in 1:length(filelist)){
	boxplot(ldf[[i]]$V2, ylim=c(0,0.5))
	}


par(mfrow=c(4,10))
for (i in 1:10) {
	plot(trees[[i]], show.tip.label=FALSE)
}

for (i in 1:10) {
	boxplot(ldf[[i]]$V2, ylim=c(0,1))
}

for (i in 11:20) {
	plot(trees[[i]], show.tip.label=FALSE)
}

for (i in 11:20) {
	boxplot(ldf[[i]]$V2, ylim=c(0,1))
}


par(mfrow=c(4,10))
for (i in 21:30) {
	plot(trees[[i]], show.tip.label=FALSE)
}

for (i in 21:30) {
	boxplot(ldf[[i]]$V2, ylim=c(0,1))
}

for (i in 21:30) {
	plot(trees[[i]], show.tip.label=FALSE)
}

for (i in 21:30) {
	boxplot(ldf[[i]]$V2, ylim=c(0,1))
}




















sapply(ldf, function(x) boxplot(x[[2]]$V2))
ldfboxplot(ldf[[1,2]])

filelist <-lapply(files, read.delim(files, ))



data <-sapply(files, read.delim('files', header=F, sep=":"))
