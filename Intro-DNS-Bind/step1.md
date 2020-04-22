
Tout d'abord nous devons installer notre serveur Bind.

Pour cela, commençons par mettre à jour la base de données des paquets.

`sudo apt-get update`{{execute}} 

Une fois mise à jour, nous pouvons utiliser `Apt` pour installer notre pack d'outils ainsi que notre serveur bind.

`sudo apt-get install -y bind9 bind9utils dnsutils`{{execute}}

Notre serveur DNS est à présent installé, mais pas encore lancé (et ça tombe bien). Nous pouvons contrôler son statut avec la commande : 

`systemctl status bind9`{{execute}} 
