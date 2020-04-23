
Maintenant que nous avons déclaré notre domaine dans la configuration, il convient de créer et d'alimenter le fichier pour cette zone.
Pour rappel, nous avons décidé de l'appeler `db.mondomaine.local`.

## Comment fonctionne l'enregistrement des ressources d'un fichier DNS ?

Il commence par un élément important : le `SOA`.
L'enregistrement de ressources **Start Of Authority** proclame des informations importantes faisant autorité sur un espace de nom (le domaine) pour le serveur de noms. 
Un enregistrement de ressources SOA est le premier enregistrement de ressources dans un fichier de zone. 
L'exemple qui suit montre la structure de base d'un enregistrement de ressources SOA : 
<pre>
@     IN     SOA    <primary-name-server>     <hostmaster-email> (
                    <serial-number>
                    <time-to-refresh>
                    <time-to-retry>
                    <time-to-expire>
                    <minimum-TTL> )
</pre>
- Le symbole *@* place la directive *$ORIGIN* (ou le nom de zone, si la directive *$ORIGIN* n'est pas déterminée, ce qui est notre cas) en tant qu'espace de nom défini par le présent enregistrement de ressources *SOA*. 
- Le nom d'hôte du serveur de noms primaire faisant autorité pour ce domaine est utilisé pour le *<primary-name-server>* et l'adresse électronique de la personne à contacter à propos de cet espace de nom est remplacée par *<hostmaster-email>*.
- La directive *<serial-number>* est incrémentée lors de chaque modification du fichier de zone afin que BIND sache qu'il doit recharger cette zone. 
- La valeur *<time-to-refresh>* indique à tout serveur esclave combien de temps il doit attendre avant de demander au serveur de noms maître si des changements ont été effectués dans la zone. Ainsi, la valeur *<serial-number>* sera utilisée par le serveur esclave pour déterminer s'il est en train d'utiliser des données de zone périmées et doit par conséquent les rafraîchir. 
- La valeur *<time-to-retry>* précise au serveur de noms esclave l'intervalle pendant lequel il doit attendre avant d'émettre une autre requête de rafraîchissement, au cas où le serveur de noms maître ne répondrait pas. Si le serveur maître n'a pas répondu à une requête de rafraîchissement avant que la durée indiquée dans *<time-to-expire>* ne se soit écoulée, le serveur esclave cesse de répondre en tant qu'autorité pour les requêtes au sujet de cet espace de nom. 

`(cat /etc/bind/db.local|sed -e 's/localhost/mondomaine.local/g'|sed -e 's/NS\tmondomaine.local./NS\tns1.mondomaine.local./'|sed '/AAAA/d' && echo -e 'ns1\tIN\tA\t127.0.0.1') > /etc/bind/db.mondomaine.local`{{execute}}