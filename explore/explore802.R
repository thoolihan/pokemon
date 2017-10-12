library(ggplot2)
library(dplyr)

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
g <- ggplot(pkmn, aes(x = type1, y = type2)) +
 geom_jitter()
print(g)

# Plot attack by type1
g <- ggplot(pkmn, aes(x = type1, y = attack, color = type2)) +
   geom_point()
print(g)

# Plot attack by type1
g <- ggplot(pkmn, aes(x = type1, y = attack)) +
   geom_boxplot()
print(g)

# Plot attack by defense
g <- ggplot(pkmn, aes(x = defense, y = attack, color = type1)) +
   geom_point()
print(g)

# highest combo of stats
pkmn %>%
  arrange(desc(attack + defense + sp_defense + sp_attack)) %>%
  select(pokedex_number, name, attack, defense, sp_attack, sp_defense, is_legendary) %>%
  head(n = 10)

# highest attack
pkmn %>%
  arrange(desc(attack), desc(sp_attack)) %>%
  select(pokedex_number, name, attack, defense, sp_attack, sp_defense, is_legendary) %>%
  head(n = 10)

# highest sp_attack
pkmn %>%
  arrange(desc(sp_attack), desc(attack)) %>%
  select(pokedex_number, name, attack, defense, sp_attack, sp_defense, is_legendary) %>%
  head(n = 10)

# highest defense
pkmn %>%
  arrange(desc(defense), desc(sp_defense)) %>%
  select(pokedex_number, name, attack, defense, sp_attack, sp_defense, is_legendary) %>%
  head(n = 10)

# highest sp_defense
pkmn %>%
  arrange(desc(sp_defense), desc(defense)) %>%
  select(pokedex_number, name, attack, defense, sp_attack, sp_defense, is_legendary) %>%
  head(n = 10)
