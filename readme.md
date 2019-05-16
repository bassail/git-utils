# README

## Objectif de ce repo

Ce repo a pour objectif de centraliser :
- tous les hooks utiles.
- tous les scripts utiles à la configuration git.
- tous les fichiers communs relatifs à git (par exemple, template de message de commit).
___
## Liste des hooks

#### commit-msg

Force les développeurs à utiliser des messages de commit respectant la norme Conventional Commits.

##### Bypasser ce hook
Il est possible de bypasser ce hook au commit via l'argument `--no-verify`

### Comment ajouter un hook ? 
Pour ajouter un hook, se référer à la documentation Git.
Copier le hook voulu dans le répertoire hooks, mettre à jour le fichier Readme et ajouter dans le script de configuration les paramètres nécessaires (optionel).
### Comment bypasser l'ensemble les hooks ? 
Pour bypasser l'ensemble des hooks, il suffit de supprimer la configuration Git.
```
configit -e
```

## Liste des scripts

### `gitConfiguration.sh`
Ce script automatise la configuration des différents hooks et paramétrages spécifiques présents dans ce repo. Il suffit de le lancer une seule fois pour qu'il:
- Modifie le fichier .bashrc de l'utilisateur courant
- Modifie le fichier .bash_profile de l'utilisateur courant
- Mette à disposition la commande `configit`

#### Comment l'utiliser ? 
Le lancer dans une invite de commande linux (ex: Git Bash):

``` bash
cd git-utils/scripts
./gitconfiguration.sh
```

Vous avez maintenant accès à la commande `configit`
Pour obtenir de l'aide sur son utilisation, lancer la commande `configit` avec l'argument -h ou --help:

``` bash
configit -h
```
___
## Template de message de commit

### A quoi ça sert ? 
Ce template sera affiché par défaut dans le message de commit. Il suffira ensuite de le modifier pour qu'il corresponde au commit voulu.
Ce template respecte la norme Conventional Commits.

### Comment l'utiliser ?
Ce template est défini automatiquement en lançant le script de configuration scripts/gitconfiguration.sh
Une fois le script joué, et la configuration terminée:
``` bash
git add blabla
git commit
# A cette étape, l'éditeur de texte sera ouvert, pré-rempli avec le template.
```

#### Quelles sont les règles définies dans ce message ?
Les règles définies sont celles de Conventional Commits (voir en particulier les normes Angular).

Une syntaxe s'ajoute dans le template : 
- Les éléments entre < > sont obligatoires. Les caractères < et > sont à supprimer dans le message de commit final.
- Les éléments séparés par des | (pipes) définissent un choix. Vous devez choisir une seule des possitilités. Les caractères | sont à supprimer dans le message de commit final.
- Les éléments entre [ ] sont facultatifs. Les caractères [ et ] sont à supprimer dans le message de commit final.

Si vous ne voulez remplir que la première ligne du message (les autres étant facultatives), votre message devra ressembler à :

```
feat: mon message
```

**Vous devez supprimer les éléments non remplis.**
___

## Commiter dans ce repo

Afin de commiter dans ce repo, il faut respecter les normes définies dans ce repo. Par exemple, il faut respecter le format du message de commit.
