
Avant tout, pour créer notre première zone DNS, il nous faut disposer d'un nom de domaine.
Celui-ci peut être soit interne à mon réseau (par exmeple un domaine interne d'entreprise), soit publique sur Internet, soit les deux (un nom de domaine associé à un site Internet, un service de messagerie, etc.).

- Si mon domaine est interne, alors attention à ne pas utiliser une extension de domaine publique (.com, .fr, .eu, .org etc..). En général, et par convention, on utilise les extensions `.local` ou `.lan` pour ne pas se tromper.

Dans le cas de notre exercice, je vous propose que nous choisissions un domaine interne `mondomaine.local`, puisque nous ne disposons pas d'un nom de domaine publique sur Internet.

## première étape : nous allons déclarer la zone dans la configuration

Pour ce faire, nous devons éditer le fichier `/etc/bind/named.local` et y ajouter ceci : 
<pre>
zone "mondomaine.local" {
	type "master";
	file "/etc/bind/db.mondomaine.local";
};
</pre>

[X] La première ligne défini le nom de notre domaine : ici `mondomaine.local`
[X] Ensuite avec la directive `type`, nous indiquons que nous somme le premier serveur DNS pour cette zone, on appelle ça un serveur maître (ou master)
[X] Enfin, nous indiquons dans quel fichier texte nous allons renseigner les informations pour ce domaine.
*Le nom de fichier importe peu, puisqu'il s'agit d'un paramétrage interne, l'important étant qu'il existe et soit bien renseigné.*

- Vous pouvez éditer manuellement le fichier et le renseigner comme indiqué, auquel cas afin d'éviter toute erreur, une fois renseigné, validez que vous n'avez pas commis d'erreur en saisissant la commande : `named-checkconf`
*Si cette commande vous renvoi la main sans erreur, alors vous n'avez commis aucune erreur de syntaxe. Dans le cas contraire, corrigez là.*

- Vous pouvez, sinon, utiliser la commande suivante pour alimenter le fichier automatiquement : `echo -e 'zone "mondomaine.local" {\n\ttype master;\n\tfile "/etc/bind/db.mondomaine.local";\n};\n' >> /etc/bind/named.conf.local`{{execute}}

Sécurité oblige, une petite vérification de la configuration s'impose : `named-checkconf`{{execute}}.

Si la commande de vérification de la syntaxe est correcte, alors et que vous avez ajouté cette zone, alors bravo, vous avez déclaré une nouvelle zone au sein de votre serveur DNS : Celui-ci une fois la configuration terminée, fera donc autorité sur cette zone de noms.
Vous pouvez donc passer à la suite.

