## Les espaces de nom (namespaces)

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

Pour plus d'informations, vous pouvez vous référer au lien : `https://en.wikipedia.org/wiki/Linux_namespaces` {{open}}

## Executer un processus dans un 
