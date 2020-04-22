
Avec Linux, toutes les actions réalisées par le systèmes se font par le biais d'`appels système`. Le noyeu de Linux dispose de 330 appels systèmes qui permettent des opérations comme la lecture d'un fichier, la demande d'arrêt d'un processus, ou encore la vérification de drois d'accès sur un fichier. Toutes les applications sont utilisatrices de ce jeu d'appels système pour réaliser les opérations.

`AppArmor` est un gestionnaire permettant de définir des stratégies qui décrivent quelles parties du système sont accessible par des programmes.

Vous pouvez voir quel est le profil par défaut d'`AppArmor` en executant la commande : 
`cat /proc/$DBPID/attr/current`{{execute}}

Ici le profil pour Docker est : `docker-default (enforce)`.

Avant la version `1.13` de Docker, sa politique AppArmor était stockée dans `/etc/apparmor.d/docker-default`, et était réécrite à chaque démarrage du service. Depuis cette version, Docker génère le fichier `docker-default` dans un volume temporaire (tmpfs), puis utilise `apparmor_parser` pour le charger dans le noyau, avant de supprimer le fichier.

Le modèle est accessible à l'adresse : `https://github.com/moby/moby/blob/a575b0b1384b2ba89b79cbd7e770fbeb616758b3/profiles/apparmor/template.go`{{open}}

`Seccomp` quant à lui, offre la possibilité de limiter les appels systèmes qui peuvent être réalisés par un processus, lui interdisant par exemple de charger un module au noyau, ou de changer les permissions d'un fichier.

Son fichier de configuration par défaut pour Docker est disponible à l'adresse : `https://github.com/moby/moby/blob/a575b0b1384b2ba89b79cbd7e770fbeb616758b3/profiles/seccomp/default.json`{{open}}

Lorsqu'il est appliqué à un processus, cela signifie que celui-ci est limité dans sa capacité à utiliser des appels systèmes. S'il tente de réaliser un appel qu'il n'est pas autorisé à faire, il se verra renvoyer l'erreur suivante : "`Operation Not Allowed"`".

L'état de Seccomp est également stocké dans un fichier.

`cat /proc/$DBPID/status`{{execute}}

`cat /proc/$DBPID/status | grep Seccomp`{{execute}}
Ici, les statuts sont les suivants : 
- 0 : désactivé 
- 1 : strict
- 2 : filtering

