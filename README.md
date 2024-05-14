### Build Optimizer

Given a csv file with attributes, it finds the most stat-efficient items for the given criteria. I am too lazy to set up command line arguments, so you'll have to edit the main.lua file and then call
>lua main.lua

### CSV Requirements
This optimizer assumes that the first row is the column names, and the first column is the row names.

Additionally, the second column must be an item price column, and every item must have a price.

### Optimization

Given a stat, the items are sorted in order of the items with the most of that stat, and then the top 6 are put into the build.
#### Multi-Stat Optimization
In the case of multiple stats, for each stat column, we calculate its worth in price. These prices per stat are then averaged and that average is used to convert the stats into their price value. These price values are added together before applying the single stat optimization.