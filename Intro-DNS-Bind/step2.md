

#### Organisation des fichiers de configuration

Tout la configuration de notre serveur DNS est localisée dans le répertoire `/etc/bind`
`ls /etc/bind`{{execute}}

#### Ce répertoire est constitué de deux familles de fichiers différents :
 
**Les fichiers de configuration du service bind à proprement parler :**

`named.conf :` Le fichier de configuration principal de Bind
*Ce fichier contenait historiqment tous les paramètres du service. Sur nos distributions modernes, il a été sépara en trois fichiers, que nous allons détailler juste après. Si vous l'éditez, il ne contiens que trois `include` car il a été séparé en trois parties principales :*

    `cat /etc/bind/named.conf`{{execute}}

`named.conf.options :` C'est le premier bloc de configuration, destiné a accueillir toutes les options liées au fonctionnement du service (port d'écoute, options, redirecteurs, sécurité etc.).
    `cat /etc/bind/named.conf.options`{{execute}}

`named.conf.default-zones :` C'est le fichier contenant le paramétrage des zones par défaut : en général, et sauf paramétrage spécifique, nous ne touchons pas à ce fichier.
*Ce fichier contiens les zones par défaut forward, reverse, et broadcast.*
    `cat /etc/bind/named.conf.default-zones`{{execute}}

`named.conf.local :` C'est le fichier dans lequel nous allons pouvoir déclarer toutes les zones DNS
*Dans ce fichier, nous déclarerons toutes les zones que nous souhaitons que notre serveur DNS gère*.
    `cat /etc/bind/named.conf.local`{{execute}}


**Les fichiers contenant la configuration de nos zones DNS :**
*Ce sont tous les fichiers qui commencent par `db.`. Ces fichiers contiennent les données relatives aux zones DNS déjà utilisées par le serveur DNS.*
    `cat /etc/bind/db.*`{{execute}}


