
Les namespaces sont fondamentales pour les conteneurs Docker. Les Namespaces sont une fonctionnalité du noyau Linux, qui permet à différents processus d'avoir chacun une vue différente de certaines parties du système, comme le réseau, le système de fichiers, ou les processus.

Quand un conteneure est démarré, son fournisseur (par exemple Docker) va créer un namespace afin qu'il s'execute dans un bac-à-sable (sandbox) dédié. En faisant ça, le processus sera cloisonné dans sa zone de nom, et aura l'impression qu'il est seul sur le système.

Les zones de nom disponibles sont : 
- ** Mounts ** (mnt) : les montages
- ** Process ID ** (pid) : les processus 
- ** Network ** (net) : les réseaux 
- ** Interprocess Communication ** (ipc) : la communication inter-processus
- ** UTS ** (hostnames) : la résolution des noms d'hôtes
- ** User ID ** (user) : les utilisateurs
- ** Control group ** (cgroup) : les cgroups

Pour plus d'informations, vous pouvez vous référer au lien : `https://en.wikipedia.org/wiki/Linux_namespaces`{{open}}

## Executer un processus dans un espace de nom. 

Sans pour autant devoir utiliser des environnements d'execution comme Docker, un processus peut devoir évoluer dans son propre espace de noms, et pour ce faire, des commandes comme `unshare` peuvent vous aider.

L'aide ici : `unshare --help`{{execute}}

Avec `unshare`, il est possible de lancer un processus dans son propre espace de nom, comme par exemple la zone `pid`. En dissociant ici l'espace de nom `PID` de l'hôte; notre processu pense donc qu'il est seul à s'executer sur la machine.

`sudo unshare --fork --pid --mount-proc bash
ps
exit`{{execute}}

## Que se passe-t'il lorsque les namespaces sont partagés ?

D'un point de vue du système hôte, les espaces de nom sont des `inodes` stockés sur le système de fichiers. Cela permet aux processus de pargafer/utiliser le même espace de noms, leur permettant ainsi de se voir et d'intéragir.

Pour ceux qui se posent la question, `Un nœud d'index ou inode (contraction de l'anglais index et node) est une structure de données contenant des informations à propos d'un fichier ou répertoire stocké dans certains systèmes de fichiers (notamment de type Linux/Unix). À chaque fichier correspond un numéro d'inode (i-number) dans le système de fichiers dans lequel il réside, unique au périphérique sur lequel il est situé.`

Listez tous les espaces de nom : `ls -lha /proc/$DBPID/ns/`{{execute}}

Maintenant nous allons utiliser un nouvel outil : `NSEnter`, qui est utilisé pour attacher un processus à un espace de nom existant. Cette commande est notamment très utile losque l'on veut débogger.

L'aide ici : `nsenter --help`{{execute}}

`nsenter --target $DBPID --mount --uts --ipc --net --pid ps aux`{{execute}}

Si l'on utilise Docker, les espaces de nom peuvent être partagés en utilisant une syntaxe de type : ** `container:<container-name>` ** .
Par exemple, la commande suivante va permettre d'attacher les espaces de nom d'un container nginx avec celui de notre DB : 

`docker run -d --name=web --net=container:db nginx:alpine
WEBPID=$(pgrep nginx | tail -n1)
echo nginx is $WEBPID
cat /proc/$WEBPID/cgroup`{{execute}}

Comme l'espace de nom réseau a été partagé, il est donc présent dans la liste des espaces de nom pour ce container : 
`ls -lha /proc/$WEBPID/ns/`{{execute}}

D'autre part, l'espace de nom `'net'` de nos deux processus pointe donc vers la même destination : 

`ls -lha /proc/$WEBPID/ns/ | grep net 
ls -lha /proc/$DBPID/ns/ | grep net`{{execute}}

