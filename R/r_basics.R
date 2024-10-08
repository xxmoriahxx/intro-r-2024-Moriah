#### R Basics ####
# "A foolish consistency is the hobgoblin of 
#   little minds"   -Ralph Waldo Emerson 

# Literals ----
"this is a string literal" #double quotes preferred in R, but not required
42

# Operators ----
2 + 3 # note the spacing
2 - 3
2 * 3 # multiplication
2 / 3
2 ** 3 # be careful, this is an exponent
2 ^ 3

#Comparison
2 == 2
"joe" == "Joe"  # false because R is case sensitive
2 == 1 + 1  # Okay
2 == (1 + 1)   # Better because it's clearer
2 != 1 # TRUE statement because exclamation is negation
2 >= 3 # FALSE statement
TRUE == 1 # yes because 1 means TRUE
FALSE == 0 # yes
isTRUE(TRUE) # yes it is
isTRUE(1) # no it's not
?isTRUE # queries built-in help

2 < 3 & 2 > 3 # both have to pass the test, so it's false
2 < 3 | 2 > 3 # either on can be true
2 < 3 & (2 == 1 | 2 == 2) # grouping statements for ordering

# type matters (sometimes)
"joe" # string or character type
typeof("joe") # numeric type
typeof(42) # numeric type (double precision, floating to the decimal point)
typeof(TRUE) # logical or Boolean
42 == "42" # it's TRUE - equality across types
identical(42, "42") # no, type matters for identicalness

# variables ----
x <- "this is a string" # in R, read as assigning the string to variable x
x <- 10
typeof(x)
x ^ 2 # always refer to as the assigned value
x <- pizza
my var <- 42 # not everything though
my_var <- 42 # that's better
my_var = 42 # works but not standard in R
x <- my_var # helps reader follow assignment direction

# readability - all lowercase, don't use dots in variable names
x



# data structures ----
# vectors have a single dimension, like a column or row of data
a <-c ("1", "2", "3")  # anything with a is going to take the whole vector
a
a <- c(1, 2, 3)
a
a + 1

a <- c(1, 2, 3, "4") # R will autotype to form that works (character)
a
typeof(a)

a <- c(1, 2, 3)
a < 3 # is this true or false for each item

any (a < 3) # tests whether any comparison TRUE
all (a< 3) # tests whether all comparisons TRUE

3 %in% a # testing membership in a vector
4 %not in% a #nope
!4 %in% a # this is how you do it!



# data frames - the key structure for data science, multi-dimensional
#   collections of vectors
df <- data.frame(a = c(1, 2, 3),
                 b = c("joe", "tammy", "matt")) # collection of vectors
df
df$a # references single column
df$b

df$mode <- c("bike", "car", "bus") # adding a column
df
summary(df) # summarizes by column


# Special type: factors, and putting it all together ----
# factors are categorical variables with a fixed set of
#   potential values


