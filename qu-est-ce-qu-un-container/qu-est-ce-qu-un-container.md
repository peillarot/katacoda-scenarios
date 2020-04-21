## Processus

Un container n'est qu'un simple processus du système au sein d'un environnement particulier. Lancez par exemple ce container Redis afin que nous puissions voir ce qu'il se passe sur le système.

`docker run -d --name=db redis:alpine`{{execute}}

Là, le container Docker lance le processus appelé redis-server. D'un point de vue de l'hôte, nous constatons que le processus s'execute bien et dispose d'un numéro de processus propre à l'hôte.

`ps aux | grep redis-server`{{execute}}

Docker peut également nous aider à identifier les caractéristiques du processus (PID, PPID) via la comande `docker top db` {{execute}}

Mais qui est le processus parent (PPID) ? Utilisez `ps aux | grep <ppid>`{{execute}} pour trouver le processus parent.

La commande `pstree` va afficher tous les processus enfants d'un processus. Voyez par vous même l'arborescence des processus enfants de Docker avec la commande `pstree -c -p -A $(pgrep dockerd)`{{execute}}

Comme vous pouvez le voir, d'un point de vue de l'hôte Linux, ce sont de processus standard, avec les mêmes propriétés qu'un autre processus du système.

## Répertoire des processus

Linux s'appuie sur une série de fichiers spéciaux et leur contenus afin de gérer notamment ses processus. Cela peut donc être intéressant de naviguer dans ces fichiers et modifier leur contenu afin de découvrir un peu mieux le fonctionnement de ces containers, vis à vis du système.

La configuration de chaque processus se situe dans le répertoire `/proc`. Aussitôt que vous connaissez le PID du processus, vous pouvez identifier son sous répertoire de configuration.

`DBPID=$(pgrep redis-server)
echo Redis is $DBPID
ls /proc`{{execute}}

Chaque processus a sa propre configuration et ses propres options de sécurité, que vous pouvez voir : `ls /proc/$DBPID`{{execute}}

Par exemple, vous pouvez voir et mettre à jour les variables d'environnement de ce procesuss : `cat /proc/$DBPID/environ`{{execute}}

Vous pouvez contrôler via la commande `docker exec -it db env`{{execute}}
 
