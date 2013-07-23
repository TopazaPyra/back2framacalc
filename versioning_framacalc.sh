#!/bin/bash
# Script vérifiant la différence entre la dernière sauvegarde du framacalc et la version actuelle.
# S'il existe une différence, le script fait une nouvelle sauvegarde.
#
# ADRESSE_CALC correspond à l'adresse d'export html de votre framacalc (obtenue en cliquant 
# sur l'engrenage en haut à gauche de votre tableau)
#
# REPERTOIRE correspond au répertoire qui contiendra vos sauvegardes

ADRESSE_CALC="http://framacalc.org/_/moncalc/html"
REPERTOIRE="/home/utilisateur/repertoire"

DERNIERE_COPIE=$(ls -t $REPERTOIRE | head -1)
NB_FICHIERS=$(ls -A $REPERTOIRE | wc -l)

wget $ADRESSE_CALC -O $REPERTOIRE/fichier_temp

if test $NB_FICHIERS -lt 1
then
	mv $REPERTOIRE/fichier_temp $REPERTOIRE/$(date +%d%m%Y_%H%M).html
else
	if test $(diff $REPERTOIRE/fichier_temp $REPERTOIRE/$DERNIERE_COPIE | wc -l) -eq 0
	then
		rm $REPERTOIRE/fichier_temp
	else
		mv $REPERTOIRE/fichier_temp $REPERTOIRE/$(date +%d%m%Y_%H%M).html
	fi
fi
