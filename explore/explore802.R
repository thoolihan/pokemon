library(ggplot2)

pkmn <- read.csv(unz("data/kaggle/pokemon802.zip", "pokemon.csv"))

print(names(pkmn))

print(pkmn[pkmn$name == "Pikachu",])

print(summary(pkmn$classfication))

types <-table(pkmn$type1, pkmn$type2)
print(types)
View(as.data.frame.matrix(types))

# g <- ggplot(pkmn, aes(x = type1, y = type2, fill = classfication)) +
#   geom_jitter()
# print(g)

g <- ggplot(pkmn, aes(x = type1, y = attack)) +
   geom_boxplot()
print(g)
