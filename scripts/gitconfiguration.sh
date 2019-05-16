#!/bin/bash

############## VARIABLES ##############

GIT_UTILS_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
GIT_UTILS_PATH="$(dirname "$GIT_UTILS_SCRIPT_PATH")"

#######################################

# LOG
function log(){
	echo "[GIT CONFIGURATION] $1"
}

# USAGE
display_usage() { 
    cat <<HELP_USAGE

	$0  [-g | -l] [-d] [-h] <file>

	-h  Afficher l'aide.
	-g  Configuration globale git.
	-l  Configuration locale git.
	-e  Exclure un repo de la configuration git globale. Commande à jouer depuis un repo git. 
	-d  Suppression de la configuration. A coupler avec -l ou -g. Exemple : gitconfiguration -g -d. L'argument -d doit obligatoirement être le deuxième argument.
HELP_USAGE
}

configuration_git(){
	# AIDE
	if [[ "$1" == "-h" || "$1" == "--help" || "$#" -lt 1 ]] ; then
		display_usage
		return 
	fi

	if [ "$1" == "-g" ] ; then
		SCOPE="--global"
		SCOPE_LABEL="globale"
	else
		SCOPE=""
		SCOPE_LABEL="locale"
	fi

	if [[ "$1" == "-e" || "$2" == "-e" ]] ; then
		log "Mise à niveau de la configuration locale : template de message vide"
		git config commit.template "$GIT_UTILS_PATH/message-empty/template-commit"
		log "Mise à niveau de la configuration locale : "
		git config core.hooksPath "$GIT_UTILS_PATH/hooks-empty/"
		return
	fi

	if [ "$2" == "-d" ] ; then
		log "Suppression de la configuration $SCOPE_LABEL du template de message de commit"
		git config $SCOPE --unset-all commit.template
		log "Suppression de la configuration $SCOPE_LABEL du répertoire de hooks"
		git config $SCOPE --unset-all core.hooksPath
	else
		log "Configuration $SCOPE_LABEL répertoire de hooks  dans $GIT_UTILS_PATH/hooks/"
		git config $SCOPE core.hooksPath "$GIT_UTILS_PATH/hooks/"

		log "Configuration $SCOPE_LABEL template message de commit  dans $GIT_UTILS_PATH/message/template-commit"
		git config $SCOPE commit.template "$GIT_UTILS_PATH/message/template-commit"
	fi

	log "Configuration terminée"
}

configit(){
	configuration_git $@
}

add_in_bashrc(){
	echo "source $GIT_UTILS_SCRIPT_PATH/gitconfiguration.sh" >> ~/.bashrc
	source $GIT_UTILS_SCRIPT_PATH/gitconfiguration.sh
	log "Ajout du fichier gitconfiguration.sh dans le bashrc. Vous pouvez maintenant utiliser la commande configit."
}

add_in_bash_profile(){
	echo "source ~/.bashrc" >> ~/.bash_profile 
	log "bashrc ajouté dans bash_profile"
}

if ! grep -q "gitconfiguration" ~/.bashrc ; then
	add_in_bashrc
fi

if ! grep -q "bashrc" ~/.bash_profile  ; then
	add_in_bash_profile
fi