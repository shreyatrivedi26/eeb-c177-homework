iris
head(iris)
tail(iris)

#how to read in a .csv file in R?
my_csv = read.csv("myfile.csv",sep = ",",header = T)


summary(iris)
summary(iris$Sepal.Length) #Summary of the column Sepal length 
iris$Sepal.Length[126] #reading the 126th value from sepal length column

#gives column names
names(iris)

#changing headers to lowercase:
names(iris)=tolower(names(iris)) #replacing the older header with lowercase headers 

#dplyr Package:
library(dplyr)

virginica <- filter(iris, species == "virginica") #filters the entries with specie "virginica"
virginica1 <- subset(iris, species == "virginica") #subsets the entries with specie "virginica"
head(virginica)# This dispalys the first six rows
head(virginica1)#same as above

sepalLength6 <- filter(iris, species == "virginica", sepal.length > 6) #another filter at sepal length
tail(sepalLength6) # compare this to head()
sepalLength6_1=subset(iris, species == "virginica" & sepal.length > 6)
tail(sepalLength6_1)

# select() the specified columns
selected <- select(iris, sepal.length, sepal.width, petal.length)
# select all columns from sepal.length to petal.length
selected2 <- select(iris, sepal.length:petal.length) #using : for the continuity in numbers
head(selected, 4)
head(selected2, 4)

# selected and selected2 are exactly the same
identical(selected, selected2) #TRUE means same

# create a new column that stores logical values for sepal.width greater than half of sepal.length
newCol <- mutate(iris, greater.half = sepal.width > 0.5 * sepal.length)
tail(newCol)

#Question: Challenge: Out of the 150 flowers, find how many satisfy this condition. 
#Hint: use the sum() function on newCol$greater.half

print("Number of flowers with sepal width greater than half of sepal length are:")
sum(newCol$greater.half) #this is equal to sum(newCol$greater.half=="TRUE")
sum(newCol$greater.half=="TRUE")#sums up the true cases

sum(newCol$greater.half=="FALSE") #False cases 

# arrange()
newCol <- arrange(newCol, petal.width) #logical column arranged according to the 
#descending order of petal width
tail(newCol)

# The chain operator, or the pipeline %>%
# This will first filter, and then arrange our data. 
#Note that here the order in which you call functions does not matter, but in other cases it might.
arr.virg <- newCol %>% filter(species == "virginica") %>%
  arrange(sepal.width)
arr.virg[30:35,] # will show us rows 30 through 35 and all columns

# You can also arrange in descending order using desc() on what you arrange by
#arrange(desc(sepal.width))
#summarise()
summarise(arr.virg, mean.length = mean(sepal.length, na.rm = TRUE))

#Challenge2: The standard deviation gives how much individual values vary from the mean. 
#Find the standard deviation of sepal.length using summarise() and sd().

summarise(arr.virg, stdev.length = sd(sepal.length, na.rm = TRUE))



# Visualizations:
plot(iris)

#specific x and y axis defined:
# use ?plot to read more about other arguments
plot(iris$sepal.width, iris$sepal.length)

# Histogram:
hist(iris$sepal.width)
