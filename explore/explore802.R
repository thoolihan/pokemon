library(ggplot2)
library(dplyr)
library(rlang)

pkmn <- read.csv(unz("data/kaggle/pokemon802.zip", "pokemon.csv"))
pkmn <- pkmn %>%
  mutate(bulbapedia_url = paste("https://bulbapedia.bulbagarden.net/wiki/", name, sep = ""),
         serebii_url = paste("https://www.serebii.net/pokedex-sm/", sprintf("%03d", pokedex_number), ".shtml", sep = ""),
         gamefreak_url = paste("https://www.pokemon.com/us/pokedex/", tolower(name), sep = ""),
         pokeapi_url = paste("http://pokeapi.co/api/v2/pokemon/", pokedex_number, sep = ""))

print(names(pkmn))

print(pkmn[pkmn$name == "Pikachu",])

print(summary(pkmn$classfication))

types <-table(pkmn$type1, pkmn$type2)
print(types)
View(as.data.frame.matrix(types))

# Plot type1 vs type2
print(qplot(x = type1, y = type2, data = pkmn, geom = "jitter"))

# Plot attack by type1
print(qplot(x = type1, y = attack, data = pkmn, color = type2, geom = "point"))

# Plot attack by type1
print(qplot(x = type1, y = attack, data = pkmn, geom = "boxplot"))

# Plot attack by defense
print(qplot(x = defense, y = attack, data = pkmn, color = type2, geom = "point"))

show_best <- function(pk, sort_expr, description = "", n = 10, ...) {
  print(description)
  print(pk %>%
          arrange(., eval_tidy(sort_expr, data = pk)) %>%
          select(pokedex_number, name, attack, defense, sp_attack, 
                 sp_defense, is_legendary) %>%
          head(., n = n))
}

show_best(pkmn, quo(desc(attack + defense + sp_defense + sp_attack)), description = "sum of stats")
show_best(pkmn, quo(desc(attack)), description = "attack")
show_best(pkmn, quo(desc(sp_attack)), description = "sp_attack")
show_best(pkmn, quo(desc(defense)), description = "defense")
show_best(pkmn, quo(desc(sp_defense)), description = "sp_defense")

non_leg <- filter(pkmn, is_legendary == FALSE)
show_best(non_leg, quo(desc(attack + defense + sp_defense + sp_attack)), description = "sum of stats")
show_best(non_leg, quo(desc(attack)), description = "attack")
show_best(non_leg, quo(desc(sp_attack)), description = "sp_attack")
show_best(non_leg, quo(desc(defense)), description = "defense")
show_best(non_leg, quo(desc(sp_defense)), description = "sp_defense")
