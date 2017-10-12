library(ggplot2)
library(dplyr)

pkmn <- read.csv(unz("data/kaggle/pokemon802.zip", "pokemon.csv"))

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

# highest attack times defense
pkmn %>%
  mutate(total_power = attack * defense * sp_defense * sp_attack) %>%
  arrange(desc(total_power)) %>%
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
