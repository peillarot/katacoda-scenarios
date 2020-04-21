
Les CAPABILITIES Linux permettent de limiter les droits d'un utilisateur. C'est en particulier vrai pour le compte root.

Les capabilities permettent de contrôler ce qu'un utilisateur est capable de faire. Le compte "root" dispose de toutes les capabilities et en particulier de la capabilitie CAP-SYS-ADMIN qui lui donne ses droits étendus.
Une capabilitie doit être sans hésiter supprimée si elle n'est pas utilisée par le container. 

Docker dote par défautses containers des capacités suivantes:
- CAP_CHOWN: Avoir la capacité de changer le propriétaire d'un fichier;
- CAP_DAC_OVERRIDE: Passer outre le contrôle d'accès (Posix ACL);
- CAP_FSETID: Avoir la capacité d'utiliser chmod sans limitation;
- CAP_FOWNER: Outrepasser le besoin d'être propriétaire du fichier;
- CAP_MKNOD: Avoir la capacité d'utiliser des fichiers spéciaux; 
- CAPNETRAW: Avoir la capacité d'utiliser les sockets raw et packet ( snifiing, binding); 
- CAP_SETGID: Avoir la capacité de changer le GID;
- CAP_SETUID: Avoir la capacité de changer l'UID;
- CAP_SETFCAP: Avoir la capacité de modifier les capacités d'un fichier;
- CAP_SETPCAP: Avoir la capacité de modifier les capacités d'un autre processus;
- CAPNETBIND_SERVICE:, Avoir la capacité d'écouter sur un port inférieur à 1024;
- CAPSYSCHROOT: Avoir la capacité de faire un change root;
- CAP_KILL: Avoir la capacité de killer un processus;
- CAPAUDITWRITE: Avoir la capacité d'écrire des logs Kernels (par exemple pour changer un password);

L'ajout d'une capabilitie ajoute des vulnérabilités ce qui peut rompre l'isolation du container.

Le fichier `status` du processus contient entre autre les flags des capabilities. 

`cat /proc/$DBPID/status | grep ^Cap`{{execute}}

Ce flag est stocké sous forme de masque de bits et peut être décodé avec la commande `capsh` : 

`capsh --decode=00000000a80425fb`{{execute}}

