## Ennemis et projectiles

### Commun

- Les ennemis n'ont pas de collision entre eux
- Les tuer fait faire un petit rebond au joueur

### Rampeur

- Marche au sol (assez lentement)
- Peuvent avoir une direction de base dans un sens comme dans l'autre
- Soumis à la gravité (tombe s'il y a un trou)
- Se cogne sur les murs (les fait aller dans l'autre sens)
- Ne se cogne avec rien d'autre que le joueur et les murs statiques
- Tue lorsqu'on rentre en contact depuis le côté
- Meurt lorsqu'on saute sur sa tête

### Canon

- Hérite du « Rampeur »
- Tir un boulet vers le haut, qui retombe et tue si on le touche
- Le canon ne bouge plus pendant que le boulet est jeté
- Le canon rebouge un peu une fois le boulet retombé dedans, puis recommence à tirer son boulet
- Résumé : il bouge, il s'arrête un temps, il tire son boulet, il attend qu'il retombe, une fois qu'il est retombé, il repart immédiatement après, et quelques temps après il s'arrête à nouveau et recommence.
- Le boulet tue le joueur s'il le touche (le boulet ne peut pas être détruit en sautant dessus).

### Tortue

- Hérite du « Rampeur »
- Lorsqu'on saute sur lui, il ne meurt pas, mais se transforme en une sorte de « toupie » qui va très vite de gauche à droite (qui est donc l'équivalent technique d'un « Rampeur » qui va vite).

### Œeil

- Se déplace de haut en bas de quelques pixels seulement
- Peut être tuer en sautant sur sa tête
- Tue lorsqu'on fonce dessus
- Le rebond du joueur quand il le tue est supérieur aux autres ennemis

### Boule électrique

- Tourne autour d'un bloc (dans le sens anti-horaire)
- Tue si on touche

### Grenouille 

- Saute en haut et sur le côté
- Peut se tuer en sautant sur la tête
- Tue si on touche

### Bloc arc

- Tir des flèches à intervalle régulier dans une direction
- Les flèches meurent si on tombe dessus
- Les flèches tuent si elles touchent
- Les flèches restent accrochés au mur sur lequel elle fonce durant quelques secondes


## Plateformes

### Plateforme en mouvement horizontal

- Bouge en permanence de gauche à droite (cogner un mur => changement de direction).
- Collision depuis le haut seulement (on passe à travers en sautant par dessous).

### Plateforme en attente

- Ne bouge pas tant qu'on est pas grimpé dessus.

### Plateforme tombante

- Ne bouge pas.
- Descend sous le poids du joueur.


## Collectables

### Pièce

- Est récupérée quand on passe dessus.
- Augmente le score de 1.

### Boost de vitesse

- Est récupéré quand on passe dessus.
- Fait accélérer le joueur (par ex. se déplace 2 fois plus vite ; mais ne saute pas 2 fois plus haut) durant un temps (par ex. 10 secondes).
- Le joueur laisse une trainée de particules dans cet étant.


## Blocs

### Ressort

- Fait changer le joueur de direction.
