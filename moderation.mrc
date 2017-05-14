;;;;;;;;;;;;;;;;;;;;;;;;
;   Moderation.mrc     ;
; Addon de modération  ;
;   Édité par Damien   ;
;  Pour le réseau IRC  ;
;       Discutea       ;
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Version IRC-Op  ;;;

menu nicklist {
  + IRCopérateur +
  .SANick:sanick $$1 $$input(Par quel pseudo voulez-vous remplacer $$1 ?,eok10,Changement de pseudo - /Sanick,Pseudo_ $+ $rand(1000,99999))
  .BadNick:msg badserv badnick $$1
  .Nicklock:/nicklock $$1 $$input(Quel pseudo voulez-vous bloquer pour $$1 ?,eok10,Blocage de pseudo - /NickLock,$$1)
  .NickUnload:/nickunlock $$1 $$1
  .Sajoin:/sajoin $$1 $$input(Sur quel canal voulez-vous sajoin $$1 ? (N'oubliez pas le #),eok15,Sajoin sur un canal - /Sajoin,#Aide)
  .Sapart:/sapart $$1 #
  .-
  ./Kill
  ../Kill Comportement:/kill $$1 [Exp/Comportement] Merci de revoir votre attitude et calmer vos ardeurs sous peines de sanctions ultérieures.
  ../Kill Flood:/kill $$1 [Exp/Flood] L'abus de répétition de caractères ou de lignes n'est pas sain et ne peut être toléré lorsque celui-ci nuit à la lisibilité de nos canaux de discussions.
  ../Kill Fantôme:/kill $$1 [Exp/Ghost] Déconnexion forcée d'un utilisateur fantôme.
  ./Shun
  ..2 Heures:/shun $$1 2h :Silence.
  ..4 Heures:/shun $$1 4h :Silence.
  ..8 Heures:/shun $$1 8h :Silence.
  ..12 Heures:/shun $$1 12h :Silence.
  ..24 Heures:/shun $$1 24h :Silence.
  ..48 Heures:/shun $$1 48h :Silence.
  ..5 Jours:/shun $$1 5d :Silence.
  .-
  ./Gline (*@Host - 48 heures)
  ../Gline Comportement:/_modermrc_gline $$1 48h comportement
  ../Gline Flood:/_modermrc_gline $$1 48 flood
  ./Gline ( $+ $_modermrc_getident($$1) $+ @* - 48 heures)
  ../Gline Comportement:/gline $_modermrc_getident($$1) $+ @* 48h :[Exp/Comportement] Attitude délétère n'ayant que pour but de nuire à la bonne tenue des canaux de discussions et/ou au respect des utilisateurs.
  ../Gline Flood:/gline $_modermrc_getident($$1) $+ @* 48h :[Exp/Flood] La prochaine fois, tu éviteras de t'endormir sur ton clavier ou veillera à ce que ton chat n'utilise celui-ci afin de venir remplir nos canaux de discussions de répétitions insistantes.
  .-
  ./Gline (7 jours)
  ./Gline (30 jours)
  ./Gline (90 jours)
}

alias -l _modermrc_getident {
  var %nick-ident = $remove($gettok($address($1,3),1,$asc(@)),*!*)
  return %nick-ident
}

alias _modermrc_gline {
  var %target $1 | var %duree $2 | var %motif $3
  var %expire (Expire le $asctime($calc($ctime + $duration(%duree)),dd/mm/yyyy à HH.nn) $+(GMT,$asctime(z)))
  echo -a %target - %duree - %motif
  if (%duree == $null) { var %duree 24h }
  elseif (%motif == $null) { var %motif noreason }
  else { goto %motif }
  ; Liste des motifs recevables : noreason - comportement - flood - pervers - age - contournement - indesirable - incitation - spam - vpn - xeno - religion - libre
  :noreason
  .gline %target %duree :Faut-il réellement un motif ? Il ne semble pas que ça soit le cas... %expire
  return
  :comportement
  .gline %target %duree :[Exp/Comportement] Attitude délétère n'ayant que pour but de nuire à la bonne tenue des canaux de discussions et/ou au respect des utilisateurs. %expire
  return
  :flood
  .gline %target %duree :[Exp/Flood] La prochaine fois, tu éviteras de t'endormir sur ton clavier ou veillera à ce que ton chat n'utilise celui-ci afin de venir remplir nos canaux de discussions de répétitions insistantes. %expire
  return
  :pervers
  .gline %target %duree :[Exp/BAP] X %expire
  return
  :age
  .gline %target %duree :[Exp/Age] Votre profil indiquant un âge différent à chacune de vos précédentes connexions, nous ne pouvons donc connaître votre âge réel et autoriser votre présence ici. %expire
  return
  :contournement
  .gline %target %duree :[Exp/Contournement] Vous contournez actuellement une sanction précédente, ceci étant contraire à la charte, vous y retournez donc. %expire
  return
  :indesirable
  .gline %target %duree :[Exp/PNG] Persona non grata - Tricard étant, votre présence n'est point nécessaire ici. %expire
  return
  :incitation
  .gline %target %duree :[Exp/Incitation] L'incitation au non respect de la charte et/ou à des comportements dolosifs pouvant être punis par les lois en vigueur n'est pas admise. %expire
  return
  :spam
  .gline %target %duree :[Exp/Spam] Notre site ressemble-t-il tant que ça à un panneau publicitaire ? C'est pourtant pas le cas, abstient-toi donc de venir diffuser tes liens à caractère publicitaire la prochaine fois. %expire
  return
  :vpn
  .gline %target %duree :[Exp/VPN] Les services permettant d'anonymiser votre connexion ne sont pas admis ici pour des raisons de sécurité. Veuillez par conséquent désactiver ceux-ci pour accéder à notre plateforme de discussions. %expire
  return
  :xeno
  .gline %target %duree :[Exp/PHO] Les propos à caractère xénophobe, homophobe, antisémite et/ou raciste sont priés de rester en dehors de nos canaux de discussions. %expire
  return
  :religion
  .gline %target %duree :[Exp/Rel] Nos canaux de discussions étant religieusement neutre, merci de respecter ceci et d'éviter toute propagande pour la religion ici. Les tentatives de radicalisation sont signalées aux autorités. %expire
  return
  :libre
  .gline %target %duree :[Exp/Divers] $$?="Pour quel motif voulez-vous bannir %target pendant %duree ?"
  return
}

on *:START:{ echo -a 04| ***14 Moderation.mrc (12IRCop14) 04***| 07 Le plugin de modération 12Discutea07 (12version IRCop07) par 04Damien07 a bien été chargé. | halt }
