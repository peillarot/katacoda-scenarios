
Maintenant que nous avons déclaré notre domaine dans la configuration, il convient de créer et d'alimenter le fichier pour cette zone.
Pour rappel, nous avons décidé de l'appeler `db.mondomaine.local`.

## Comment fonctionne l'enregistrement des ressources d'un fichier DNS ?

Il commence par un élément important : le `SOA`.
L'enregistrement de ressources **Start Of Authority** proclame des informations importantes faisant autorité sur un espace de nom (le domaine) pour le serveur de noms. 
Un enregistrement de ressources SOA est le premier enregistrement de ressources dans un fichier de zone. 
L'exemple qui suit montre la structure de base d'un enregistrement de ressources SOA : 
![SOA](/lrpei/scenarios/intro-dns-bind/assets/SOA.png)

- Le symbole *@* place la directive *$ORIGIN* (ou le nom de zone, si la directive *$ORIGIN* n'est pas déterminée, ce qui est notre cas) en tant qu'espace de nom défini par le présent enregistrement de ressources *SOA*. 
- Le nom d'hôte du serveur de noms primaire faisant autorité pour ce domaine est utilisé pour le *<primary-name-server>* et l'adresse électronique de la personne à contacter à propos de cet espace de nom est remplacée par *<hostmaster-email>*.
- La directive *<serial-number>* est incrémentée lors de chaque modification du fichier de zone afin que BIND sache qu'il doit recharger cette zone. 
- La valeur *<time-to-refresh>* indique à tout serveur esclave combien de temps il doit attendre avant de demander au serveur de noms maître si des changements ont été effectués dans la zone. Ainsi, la valeur *<serial-number>* sera utilisée par le serveur esclave pour déterminer s'il est en train d'utiliser des données de zone périmées et doit par conséquent les rafraîchir. 
- La valeur *<time-to-retry>* précise au serveur de noms esclave l'intervalle pendant lequel il doit attendre avant d'émettre une autre requête de rafraîchissement, au cas où le serveur de noms maître ne répondrait pas. Si le serveur maître n'a pas répondu à une requête de rafraîchissement avant que la durée indiquée dans *<time-to-expire>* ne se soit écoulée, le serveur esclave cesse de répondre en tant qu'autorité pour les requêtes au sujet de cet espace de nom. 
- La valeur *<minimum-TTL>* demande que d'autres serveurs de noms mettent en cache les informations pour cette zone pendant au moins cette durée définie. 

Notre entête SOA une fois créée pourrait donc ressembler à cela : 
![SOA2](/lrpei/scenarios/intro-dns-bind/assets/SOA_2.png)

Ensuite viennent les enregistrements à proprement parler, et nous reviendrons là dessus une fois notre fichier créé.

Pour de plus amples informations sur ce point, référez vous à la section `12.3.2` l'excellente documentation dispinible ici : `http://web.mit.edu/rhel-doc/4/RH-DOCS/rhel-rg-fr-4/s1-bind-zone.html`{{open}}

Créons à présent notre fichier de zone : `/etc/bind/db.mondomaine.local`.
Il doit ressembler à ça : 
![zone](/lrpei/scenarios/intro-dns-bind/assets/mondomaine.png)

Vous pouvez faire le choix de le réaliser à la main, auquel cas, vous pouvez utiliser l'outil `named-checkzone` pour vérifier que vous n'avez pas commis d'erreur de syntaxe : `named-checkzone mondomaine.local /etc/bind/db.mondomaine.local`{{execute}}

Sinon, executez cette commande pour créer automatiquement la zone.
`(cat /etc/bind/db.local|sed -e 's/localhost/mondomaine.local/g'|sed -e 's/NS\tmondomaine.local./NS\tns1.mondomaine.local./'|sed '/AAAA/d' && echo -e 'ns1\tIN\tA\t127.0.0.1') > /etc/bind/db.mondomaine.local`{{execute}}

puis `named-checkzone mondomaine.local /etc/bind/db.mondomaine.local`{{execute}}

## Votre service DNS est prêt à effectuer son premier démarrage !

Si toutes les étapes précédentes sont valides, et que les commandes de vérification n'ont pas renvoyées d'erreurs, alors nous sommes prêts à démarrer notre serveur DNS dans la section suivante.



