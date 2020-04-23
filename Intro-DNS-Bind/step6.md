Maintenant que tout semble OK, nous allons démarrer notre serveur Bind : 
`systemctl start bind9`{{execute}}

Si aucune erreur n'a été commise, il devrait démarrer : vous pouvez vous en assurer en visualisant son statut :
`systemctl status bind9`{{execute}}

et vous devriez avoir un joli status "Active" en vert.

## Passons maintenant à la vérification 

Et oui, comme nous vous l'avons dit précédemment, le serveur DNS `Bind` est constitué de deux parties : la configuration du serveur en lui même via les fichiers `named.conf` et les données de zones via les fichiers `db.`

Le serveur `Bind` démarrera si sa configuration ne comporte pas d'erreurs, en revanche si une erreur s'est glissée dans un fichier de zone, alors il ne vous en informera pas.

A ce stade, je ne vais pas entrer dans le détail (ce lab étant encore en cours de réalisation).

Un bon administrateur DNS vérifiera systématiquement les journaux du système afin de vérifier que toutes les zones sont bien chargées, mais je n'ai pas encore rédigé cela dans cet environnement (pbs avec le déport des logs dans le syslog) : Bref ! Nous pouvons tout de même essayer de réaliser des requettes DNS sur notre serveur afin de valider qu'il répond.

`dig @127.0.0.1 ns1.mondomaine.local`{{execute}}


Cette commande devrait vous renvoyer l'adresse IP de cet enregistrement dans la section `ANSWER SECTION`.

Si c'est le cas, alors `Bravo` ! Votre zone DNS est bien paramétrée !

## Que se passe-t'il lorsque j'essaye de résoudre www.google.com via ce service ?
Lorsque j'execute la commande : 
`dig @127.0.0.1 www.google.com`{{execute}}

je demande à mon serveur DNS local de résoudre l'hôte www sur le domaine google.com, et là, c'est le drame ! Il ne me résoud pas cette requette.
En effet, mon serveur n'a pas été encore paramétré pour renvoyer les demandes hors de son autorité vers un autre DNS (le fameux forwarder).

Nous allons résoudre ce problème dans la prochaine section !

