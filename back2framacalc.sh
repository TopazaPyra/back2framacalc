#!/bin/bash
# Script vérifiant la différence entre la dernière sauvegarde du framacalc et la version actuelle.
# S'il existe une différence, le script fait une nouvelle sauvegarde.
#
# ADRESSE_CALC correspond à l'adresse de votre framacalc (sans "/" à la fin)
#
# REPERTOIRE correspond au répertoire qui contiendra vos sauvegardes

ADRESSE_CALC="http://framacalc.org/moncalc"
REPERTOIRE="/home/utilisateur/repertoire"

EXPORT_HTML="${ADRESSE_CALC:0:21}_/${ADRESSE_CALC:21}/html"
DERNIERE_COPIE=$(ls -t $REPERTOIRE | head -1)
NB_FICHIERS=$(ls -A $REPERTOIRE | wc -l)

wget $EXPORT_HTML -O $REPERTOIRE/temp

if test $NB_FICHIERS -lt 1
then
	mv $REPERTOIRE/temp $REPERTOIRE/$(date +%Y%m%d_%H%M).html
else
	if test $(diff $REPERTOIRE/temp $REPERTOIRE/$DERNIERE_COPIE | wc -l) -eq 0
	then
		rm $REPERTOIRE/temp
	else
		mv $REPERTOIRE/temp $REPERTOIRE/$(date +%Y%m%d_%H%M).html
	fi
fi
