


# [X] - D'un point de vue réseau (DNS)

Lorsqu'un hôte connecté à un réseau souhaite résoudre un nom d'hôte afin d'obtenir son adresse IP en utilisant DNS, il interroge l'un des serveurs DNS renseigné dans sa configuration, et lui envoi une requette de résolution (directe, ou indirecte).

Exemple avec `nslookup` : `nslookup www.google.com`{{execute}}

Le serveur, lui, va alors procéder par étapes : 
- Il va découper le FQDN en deux parties : hôte (ici www) et domaine (ici google.com)
- Il va ensuite vérifier s'il héberge cette zone. C'est à dire si cette zone DNS est renseignée comme gérée dans son fichier de configuration serveur. *Techniquement, on dit qu'il cherche à savoir s'il à autorité sur la zone.*
- Si oui, il va interroger sa propre base pour chercher s'il existe un enregistrement pour l'hôte `www` sur ce domaine.
- Si non, alors on dit qu'il n'a pas autorité sur la zone, il va d'abord chercher s'il a dans son cache cet enregistement, et si oui, il répond, en précisant qu'il n'a pas autorité sur cet enregistrement (en d'autres mots, il est allé le chercher ailleurs précédemment, et donc n'est pas certain qu'il n'ai pas été modifié ou supprimé depuis.
- Ensuite, toujours dans le cas ou il ne fait pas autorité, et ne l'ai pas dans son cache, il va interroger le serveur DNS paramétré comme le plus proche de lui (son `redirecteur`, ou `forwarder` en anglais), qui va procéder de la même façon, et ce jusqu'à ce qu'un serveur DNS réponde ou jusqu'à écoulement du délais de réponse.

Si le délais de réponse n'est pas atteint, mais que l'hôte n'existe pas, la commande renverra `host not found`.
Si le délais de réponse est atteint, et ce que l'hôte existe ou non, il renverra `cannot resolve host`.


# [X] - D'un point de vue du système d'exploitation

Lorsqu'un hôte connecté à un réseau souhaite résoudre un nom d'hôte afin d'obtenir son adresse IP, plusieures étapes s'enchainent.
En effet, chaque système d'exploitation dispose de plusieurs mécanismes de résolution qui vont se succéder jusqu'à ce que la demande de résolution aboutisse, ou échoue.

Ainsi, sur tous les systèmes, et à minima, il existe deux mécanismes de résolution de nom : 
- **Résolution locale** : C'est celle qui s'opère en lisant le fichiers hosts.
Dans notre cas, il est dans `/etc` : `cat /etc/hosts`{{execute}}

*Notez que sous Windows, par exemple, il est dans `C:\WINDOWS\SYSTEM32\DRIVER\ETC`*

Pour plus d'informations : `man hosts`{{execute}} (<kbd>Q</kbd> pour fermer)

- **Résolution DNS** : C'est celle qui vise à lire les paramètres du réseau, puis à interroger l'un des serveurs DNS renseigné s'il y en a.
Historiquement, sous Unix, le fichier de configuration est dans `/etc/` et se nomme `resolv.conf`. `cat /etc/resolv.conf`{{execute}}

Pour plus d'informations : `man resolv.conf`{{execute}} (<kbd>Q</kbd> pour fermer)
Aujourd'hui, sur les distributions modernes (dans notre cas les Debian et dérivés), ce paramétrage se trouve centralisé au même emplacement que la configuration réseau : sur notre Ubuntu, il est dans `/etc/network/interfaces` et se caractérise par le paramètre `dns-nameservers` lorsque la carte réseau est paramétré en statique. 


*D'autres mécanismes spécifiques et liés à l'OS sont disponibles, par exemple la résolution *NETBIOS* en environnement Microsoft.*

## Comment savoir dans quel ordre ?
Facile, sous Unix, tout se trouve dans un fichier de configuration qui permet de paramétrer au plus près de nos besoins, l'ordre de la chaine de résolution du système, pour chaque grande famille de résolution (hôtes, réseaux, etc.).

C'est le fichier `/etc/nsswitch.conf` : `cat /etc/nssitch.conf`{{execute}}

Sous Windows, tout est stocké dans la base de registres, via la clé : `\HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\TCPIP\ServiceProvider`


