## Les cgroups (Control Groups)

Les `cgroups` ont pour rôle de limiter la quantité de ressources que peut consommer un processus.
Ces `cgroups sont des valeurs définies dans des fichiers spéciaux du répertoire /proc 

Pour voir leur paramètres sur notre container `DB`, nous pouvons lancer la commande : 
`cat /proc/$DBPID/cgroup`{{execute}}

Elles sont liés a un autre répertoire dédié à ces cgroups, à l'emplacement : 
`ls /sys/fs/cgroup/`{{execute}}


## Ou sont les stats CPU pour un processus ?

Les stats ainsi que l'utilisation du CPU pour un processus est stocké également dans un fichier : 
`cat /sys/fs/cgroup/cpu,cpuacct/docker/$DBID/cpuacct.stat`{{execute}}

Et la limite CPU partageable par le système est définie ici : 
`cat /sys/fs/cgroup/cpu,cpuacct/docker/$DBID/cpu.shares`{{execute}}

Tous les cgroups de Docker pour la configuration mémoire des containers est, elle, stockée dans le répertoire suivant : 
`ls /sys/fs/cgroup/memory/docker/`{{execute}}

Chaque sous répertoire indique l'ID du container Docker : 
`DBID=$(docker ps --no-trunc | grep 'db' | awk '{print $1}')
WEBID=$(docker ps --no-trunc | grep 'nginx' | awk '{print $1}')
ls /sys/fs/cgroup/memory/docker/$DBID`{{execute}}

## Comment configurer les cgroups ?

Une des principales capacités de Docker est de permettre de contrôler la mémoire maximum que peut consommer un conteneur. Cette opération fait appel aux `cgroups`.

Par défaut, un conteneur Docker ne dispose d'aucune limite mémoire si on ne la lui précise pas, comme nous pouvons le voir ici avec notre container `db`: 
`docker stats db --no-stream`{{execute}}

En écrivant dans le bon fichier, nous pouvons changer cela et définir une limite au processus : 
`echo 8000000 > /sys/fs/cgroup/memory/docker/$DBID/memory.limit_in_bytes`{{execute}}

Si après celà, vous essayez de lire ce même fichier, vous vous appercevrez qu'il a été converti, et vaut maintenant `7999488`. 
`cat /sys/fs/cgroup/memory/docker/$DBID/memory.limit_in_bytes`{{execute}}

Maintenant, lorsque nous interrogeons les statistiques de notre container `db`, celui-ci dispose d'une limite mémoire à `7,629M`.
`docker stats db --no-stream`{{execute}}
