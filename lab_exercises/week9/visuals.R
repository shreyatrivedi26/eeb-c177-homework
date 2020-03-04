library(ggplot2)
plot(x=iris$sepal.length, y=iris$sepal.width, 
     xlab="Sepal Length", ylab="Sepal Width",  main="Sepal Length-Width")

#qplot(x = Sepal.Length, y = Sepal.Width, data = iris, 
#      xlab="Sepal Length", ylab="Sepal Width", 
#      main="Sepal Length-Width", color=Species, shape=Species)

scatter <- ggplot(data=iris, aes(x = sepal.length, y = sepal.width)) 
scatter + geom_point(aes(color=species, shape=species)) +
  xlab("Sepal Length") +  ylab("Sepal Width") +
  ggtitle("Sepal Length-Width")

scatter + geom_point(aes(color = petal.width, shape = species), size = 2, alpha = I(1/2)) +
  geom_vline(aes(xintercept = mean(sepal.length)), color = "red", linetype = "dashed") +
  geom_hline(aes(yintercept = mean(sepal.width)), color = "red", linetype = "dashed") +
  scale_color_gradient(low = "yellow", high = "red") +
  xlab("Sepal Length") +  ylab("Sepal Width") +
  ggtitle("Sepal Length-Width")

#BOXPLOT:
boxplot(sepal.length~species,data=iris, 
        xlab="Species", ylab="Sepal Length", main="Iris Boxplot")

box <- ggplot(data=iris, aes(x=species, y=sepal.length))
box + geom_boxplot(aes(fill=species)) + 
  ylab("Sepal Length") + ggtitle("Iris Boxplot") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4) 

hist(iris$sepal.width, freq=NULL, density=NULL, breaks=12,
     xlab="Sepal Width", ylab="Frequency", main="Histogram of Sepal Width")

histogram <- ggplot(data=iris, aes(x=sepal.width))
histogram + geom_histogram(binwidth=0.2, color="black", aes(fill=species)) + 
  xlab("Sepal Width") +  ylab("Frequency") + ggtitle("Histogram of Sepal Width")

set.seed(1234)
iris1 <- iris[sample(1:nrow(iris), 110), ]
hline <- data.frame(species=c("setosa", "versicolor", "virginica"), hline=as.vector(table(iris$species)))
hline

barplot(table(iris1$species), col="black", xlab="Species", ylab="Count", main="Bar plot of Sepal Length")

bar <- ggplot(data=iris1, aes(x=species))
bar + geom_bar() + 
  xlab("Species") +  ylab("Count") + ggtitle("Bar plot of Sepal Length") +
  geom_errorbar(data=hline, aes(y=hline, ymin=hline, ymax=hline), col="red", linetype="dashed")

library(reshape2)
iris2 <- melt(iris, id.vars="species")
iris2[1:3,]

bar1 <- ggplot(data=iris2, aes(x=species, y=value, fill=variable))
bar1 + geom_bar(stat="identity", position="dodge") + 
  scale_fill_manual(values=c("orange", "blue", "darkgreen", "purple"),
                    name="Iris\nMeasurements",
                    breaks=c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
                    labels=c("Sepal Length", "Sepal Width", "Petal Length", "Petal Width"))

#5. Pie Charts:
# Quantity and Position 
quan <- as.vector(table(iris1$species))
pos <- cumsum(quan) - quan/2
quantity <- data.frame(species=c("setosa", "versicolor", "virginica"), quantity=quan, position = pos)                       

pie <- ggplot(iris1, aes(x=factor(1), fill=species)) + geom_bar(width=1) + geom_text(data=quantity, aes(x=factor(1), y=position, label=quantity) , size=5) + labs(x="", y="")
pie
pie + coord_polar() 
pie + coord_polar(theta="y")

#6-1) Line Plot 1
head(ChickWeight)

chick <- unique(ChickWeight$Chick)

group <- chick[1]
dat <- ChickWeight[ChickWeight$Chick==group,]
color <- as.vector(dat$Diet[1])
plot(dat$Time, dat$weight, type="l", ylim=range(ChickWeight$weight), col=color, 
     xlab="Time", ylab="Weight", main="Line plot")

for(i in 2:length(chick))
{
  group <- chick[i]
  dat <- ChickWeight[ChickWeight$Chick==group,]
  color <- as.vector(dat$Diet[1])
  lines(dat$Time, dat$weight, col=color)  
}


ggplot(data=ChickWeight, aes(x=Time, y=weight, color=Diet, group=Chick)) +
  geom_line() + ggtitle("Growth curve for individual chicks")

#6-2)Line Plot 2:
library(plyr)
sepal.min <- ddply(iris, "species", summarise, xval=min(sepal.length), yval=min(sepal.width))
sepal.max <- ddply(iris, "species", summarise, xval=max(sepal.length), yval=max(sepal.width))
sepal <- rbind(sepal.min, sepal.max)
sepal 

ggplot(sepal, aes(x=xval, y=yval, group = species, color=species)) +
  geom_line(aes(linetype=species), size = 1.2) +
  geom_point(aes(shape=species), size = 4) +        
  scale_shape_manual(values=c(6, 5, 4)) +               
  scale_linetype_manual(values=c("dotdash", "solid", "dotted")) +
  xlab("Sepal Length") + ylab("Sepal Width") + ggtitle("Line plot of sepal length and width")

#7-1) Density Curve 1:
d <- density(iris$sepal.width)
hist(iris$sepal.width, breaks=12, prob=TRUE, xlab="Sepal Width", main="Histogram & Density Curve")
lines(d, lty=2, col="blue")
polygon(d, col="yellow", border="blue")

density <- ggplot(data=iris, aes(x=sepal.width))
density + geom_histogram(binwidth=0.2, color="black", fill="steelblue", aes(y=..density..)) +
  geom_density(stat="density", alpha=I(0.2), fill="blue") +
  xlab("Sepal Width") +  ylab("Density") + ggtitle("Histogram & Density Curve")

#7-2) Density Curve 2:
density2 <- ggplot(data=iris, aes(x=sepal.width, fill=species))
dd_plot=density2 + geom_density(stat="density", alpha=I(0.2)) +
  xlab("Sepal Width") +  ylab("Density") + ggtitle("Histogram & Density Curve of Sepal Width")

#2. Elaboration
#1) Adding Smoothers

smooth <- ggplot(data=iris, aes(x=sepal.length, y=sepal.width, color=species)) + 
  geom_point(aes(shape=species), size=1.5) + xlab("Sepal Length") + ylab("Sepal Width") + 
  ggtitle("Scatterplot with smoothers")

# Linear model
smooth + geom_smooth(method="lm")

# Local polynomial regression
smooth + geom_smooth(method="loess")

# generalised additive model
smooth + geom_smooth(method="gam", formula= y~s(x, bs="cs"))

#2) Faceting:
facet <- ggplot(data=iris, aes(sepal.length, y=sepal.width, color=species)) + 
  geom_point(aes(shape=species), size=1.5) + geom_smooth(method="lm") +
  xlab("Sepal Length") + ylab("Sepal Width") + ggtitle("Faceting")

# Along rows
facet + facet_grid(. ~ species)

# Along columns
facet + facet_grid(species ~ .)

#3. Additionally on ggplot2:
#1) Jitter:

head(mpg)
jitter <- ggplot(mpg, aes(x=class , y=hwy)) 
jitter + scale_x_discrete() +
  geom_jitter(aes(color = class, x = class), 
              position = position_jitter(width = .05), alpha = 0.5) +
  geom_boxplot(aes(color = class), outlier.colour = NA, position = "dodge") +
  xlab("Class") + ylab("Highway miles per gallon")

#2) Volcano:
vol <- ggplot(data=iris, aes(x = sepal.length))
vol + stat_density(aes(ymax = ..density..,  ymin = -..density.., 
                       fill = species, color = species), 
                   geom = "ribbon", position = "identity") +
  facet_grid(. ~ species) + coord_flip() + xlab("Sepal Length") 

#3) Rug Plot:
ggplot(data=iris, aes(x=sepal.length, petal.length)) + geom_point() + 
  geom_rug(col="steelblue",alpha=0.1) + xlab("Sepal Length") + ylab("Petal Length")

#4) Density Curves:
install.packages("gridExtra")
library(gridExtra)

set.seed(1234)
x <- c(rnorm(1500, mean = -1), rnorm(1500, mean = 1.5))
y <- c(rnorm(1500, mean = 1), rnorm(1500, mean = 1.5))
z <- as.factor(c(rep(1, 1500), rep(2, 1500)))
xy <- data.frame(x, y, z)

# scatterplot of x and y
scatter <- ggplot(data=xy,aes(x=x, y=y)) + geom_point(aes(color=z)) + 
  scale_color_manual(values = c("orange", "purple")) + 
  theme(legend.position=c(1,1),legend.justification=c(1,1)) 

# marginal density of x - plot on top
plot_top <- ggplot(data=xy, aes(x=x, fill=z)) + 
  geom_density(alpha=.5) + 
  scale_fill_manual(values = c("orange", "purple")) + 
  theme(legend.position = "none")

# marginal density of y - plot on the right
plot_right <- ggplot(data=xy, aes(x=y, fill=z)) + 
  geom_density(alpha=.5) + coord_flip() + 
  scale_fill_manual(values = c("orange", "purple")) + 
  theme(legend.position = "none") 

# Empty plot
empty <- ggplot()+geom_point(aes(1,1), color="white") +
  theme(                              
    plot.background = element_blank(), 
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), 
    panel.border = element_blank(), 
    panel.background = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank()
  )

# Arrange the plots together
grid.arrange(plot_top, empty, scatter, plot_right, ncol=2, nrow=2, widths=c(4, 1), heights=c(1, 4))

#5)Bubble Chart:
crime <- read.csv("http://datasets.flowingdata.com/crimeRatesByState2005.tsv", header=TRUE, sep="\t")
crime_plot=ggplot(data=crime, aes(x=murder, y=burglary, size=population, label=state),guide=FALSE)+
  geom_point(color="white", fill="red", shape=21)+ scale_size_area(max_size = 15)+
  scale_x_continuous(name="Murders per 1,000 population", limits=c(0,12))+
  scale_y_continuous(name="Burglaries per 1,000 population", limits=c(0,1250))+
  geom_text(size=2.5)+ theme_bw()

#6-1) Heat Map:
dat <- iris[,1:4]
cor <- melt(cor(dat, use="p"))
head(cor)

heat <- ggplot(data=cor, aes(x=Var1, y=Var2, fill=value)) 
heat + geom_tile() + labs(x = "", y = "") + scale_fill_gradient2(limits=c(-1, 1))

#6-2) Heat Map 2:
library(scales)
nba <- read.csv("http://datasets.flowingdata.com/ppg2008.csv")
nba$Name <- with(nba, reorder(Name, PTS))
nba.m <- melt(nba)
nba.m <- ddply(nba.m, .(variable), transform, rescale = rescale(value))

heat <- ggplot(data=nba.m, aes(x=variable, y=Name)) + 
  geom_tile(aes(fill = rescale), color = "white") + 
  scale_fill_gradient(low = "white", high = "steelblue")

base_size <- 9
heat + theme_grey(base_size = base_size) + labs(x = "", y = "") +
  scale_x_discrete(expand = c(0, 0)) + scale_y_discrete(expand = c(0, 0)) +
  theme(legend.position = "none", axis.ticks = element_blank(), axis.text.x = element_text(size = base_size *0.8, angle = 330, hjust = 0, color = "grey50"))


#4: Exporting:
plot <- ggplot(data=iris, aes(x=sepal.length, y=sepal.width)) + 
  geom_point(aes(shape=species, color=species))

setwd("/home/eebc177student/Developer/Repos/eeb-c177-homework/lab_exercises/week9")

ggsave("plot1.png")
ggsave(crime_plot, file="crime_plot.png")
ggsave(dd_plot, file="density_plot.png", width=6, height=4)


#saving figures in R:
#outputfile name
pdf("myplot.pdf") 
#what plot to input
p
#in the end to comple saving  
dev.off()
iris
