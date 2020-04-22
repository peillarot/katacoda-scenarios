

Tout d'abord nous devons installer notre serveur Bind.

Pour cela, commençons par mettre à jour la base de données des paquets.

## Mise à jour de notre base de données de paquets
`sudo apt-get update`{{execute}} 

Une fois mise à jour, nous pouvons utiliser `Apt` pour installer notre pack d'outils ainsi que notre serveur bind.

## Installation de Bind9, ses utilitaires et les utilitaires système liés à DNS
`sudo apt-get install -y bind9 bind9utils dnsutils`{{execute}}


## Vérification du service.

Comme vous pouvez le voir, en utilisant le contrôleur système `systemctl`, notre service est installé, mais n'est pas démarré : 

`systemctl status bind9`{{execute}}

Nous pouvons à présent passer à l'étape suivante.
