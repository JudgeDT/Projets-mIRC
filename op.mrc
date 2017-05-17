;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Op Modération      ;;
;;;   Édité par Damien    ;;;
;;;;   Pour le réseau    ;;;;
;;;;;	   Discutea     ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


menu nicklist {
  + Opérateur +://
  Kick
  .Comportement
  .Annonces sexe
  .Coordonnées personnelles
  Ban
  .Comportement
  .Annonces sexe
  .Coordonnées personnelles
}



alias -l _modermrc_getident {
  var %nick-ident = $ial($$1).user
  return %nick-ident 
}

on *:START:{ echo -a 04| ***14 Moderation.mrc (12Opérateur14) 04***| 07 Le plugin de modération 12Discutea07 (12version Opérateur07) par 04Damien07 a bien été chargé. | halt }
