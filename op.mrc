;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Op Modération      ;;
;;;   Édité par Damien    ;;;
;;;;   Pour le réseau    ;;;;
;;;;;	   Discutea     ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


menu nicklist {
  + Opérateur +://
  Kick
  .Comportement:/cs kick # $$1 04Comportement : Merci de changer ton comportement, si tu souhaites pouvoir continuer à rester parmi-nous.
  .Annonces sexe:/cs kick # $$1 04Annonces : Tes annonces et recherches à caractère sexuel ne regardent que toi, pas besoin de les faire connaître à tout le monde.
  .Coordonnées personnelles:/cs kick # $$1 4Coordonnées personnelles : Merci de conserver tes coordonnées personnelles, personnelles.
  Ban
  .Comportement:/cs ban # $$1 04Comportement : Nous nous passerons de ton comportement et de ta présence durant les prochaines heures, soit plus sage la prochaine fois.
  .Annonces sexe:/cs ban # $$1 04Annonces : Nous ne sommes pas une maison close ni un service d'escort, merci donc de garder ce type d'annonce pour toi.
  .Coordonnées personnelles:/cs ban # $$1 04Coordonnées personnelles : Tu dois nous confondre avec l'annuaire, garde tes informations personnelles enfuies dans ton clavier.
}



alias -l _modermrc_getident {
  var %nick-ident = $ial($$1).user
  return %nick-ident 
}

on *:START:{ echo -a 04| ***14 Moderation.mrc (12Opérateur14) 04***| 07 Le plugin de modération 12Discutea07 (12version Opérateur07) par 04Damien07 a bien été chargé. | halt }
