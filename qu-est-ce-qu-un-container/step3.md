## Chroot 

Une partie importante de la conteneurisation d'un processus réside dans la capacité de celui-ci à rester confiner à l'intérieur d'un répertoire de l'arborescence, et par conséquent avoir un accès aux fichiers différent de celui de son hôte.

C'est là qu'interviens la notion de ** chroot *.

chroot (change root) est un appel système qui a également donné son nom à une commande des systèmes d'exploitation Unix permettant de changer le répertoire racine d'un processus de la machine hôte. 

Cette commande permet d'isoler l'exécution d'un programme et d'éviter ainsi la compromission complète d'un système lors de l'exploitation d'une faille. Si un pirate utilise une faille présente sur l'application chrootée, il n'aura accès qu'à l'environnement isolé et non pas à l'ensemble du système d'exploitation. Cela permet donc de limiter les dégâts qu'il pourrait causer. Cet environnement est appelé un chroot jail en anglais, littéralement une prison.

Il permet également de faire tourner plusieurs instances d'un même ensemble de services ou démons sur la même machine hôte. 


## Exemple : faire tourner une instance de terminal à l'intérieur d'un chroot.

Pour ce faire, nous allons devoir installer l'outil `debootstrap` qui nous permettra de créer un environnement système GNU/Debian dans un répertoire de notre arborescence.

- Commençons par mettre à jour la base de paquets de notre hôte Ubuntu : 
`sudo apt-get update`{{execute}}

- Maintenant installons notre paquet : 
`sudo apt-get install -y debootstrap`{{execute}}

- Créons notre répertoire : 
`sudo mkdir /espace_1`{{execute}}

- Déployons notre arborescence type dans notre répertoire : 
`sudo debootstrap stable /espace_1 https://deb.debian.org/debian/`{{execute}}

Nous avons maintenant une arborescence minimaliste dans notre répertoire : `ls /espace_1`{{execute}} . 
Notre processus (bash par exemple) va s'executer au sein de ce répertoire, tout en limitant son accès racine à celui que nous aurons défini.

- Allons y :

`chroot /espace_1 /bin/bash`{{execute}}

Comme vous le voyez, l'invite de commande a changé, là nous sommes dans un environnement cloisonné au répertoire `/espace_1`.

Pour le vérifier, je propose d'aller à la racine du système de ce processus, puis de créer un fichier de test. Une fois que nous aurons quité ce `chroot` nous constaterons que ce que nous pensions être la racine était en réalité le répertoire /espace_1 de notre système de fichier.

- Dans notre environnement `chroot` :

`cd /
ls -l 
echo "mon fichier à la racine" > /fichier_racine
ls -l`{{execute}}

- Quittons notre chroot pour retourner sur notre hôte : 

`exit`{{execute}}

- Si je me positionne à la racine de l'arborescence du système, notre fichier de test n'apparait pas : 

`cd /
ls -l`{{execute}}

- Alors qu'il est présent dans le répertoire `/espace_1` :

`cd /espace_1
ls -l`{{execute}}

Voilà ! Comme vous le voyez, ce fichier a bien été créé dans le répertoire dans lequel nous avions confiné notre processus bash.

