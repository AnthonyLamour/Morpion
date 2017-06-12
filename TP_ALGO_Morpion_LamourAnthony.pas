program morpion;

uses crt,sysutils;

{ALGO morpion
//BUT créer un morpion
//ENTREE nombre de parties, case choisi et joueur X ou O
//SORTIE victoire de l'un des joueurs

//création du type grille
type grille=tableau[1..3,1..3] de caractères

//procedures et fonctions
procedure initGrille(var G:grille);
//BUT initialiser une grille
//ENTREE une Grille
//SORTIE la grille initialiser
var
	i,j:ENTIER
DEBUT
	POUR i DE 1 A 3 FAIRE
		POUR J DE 1 A 3 FAIRE
			G[i,j]<-''
		FINPOUR
	FINPOUR
FINPROCEDURE

procedure init_part(var NomJ1:chaine,var NomJ2:chaine,var CarJ1:caractère,var CarJ2:caractère)
//BUT initialiser le jeu
//ENTREE noms des joueurs et le caractère leur correspondant
//SORTIE jeu initialisé
var
	nb:ENTIER
	echange,ch:chaine
DEBUT
	//demande du nom du joueur 1
	REPETER
		ECRIRE"Veuillez entrer le nom du joueur 1 :"
		LIRE(NomJ1)
		ECRIRE"Etes-vous sûr ? (oui ou non)"
		LIRE(ch)
	JUSQU'A (NomJ1<>'') ET (ch='oui')
	//demande du nom du joueur 2
	REPETER
		ECRIRE"Veuillez entrer le nom du joueur 2 :"
		LIRE(NomJ2)
		ECRIRE"Etes-vous sûr ? (oui ou non)"
		LIRE(ch)
	JUSQU'A (NomJ2<>'') ET (ch='oui') ET (NomJ1<>NomJ2)
	//selection aléatoire du joueur jouant en premier
	nb<-ALEATOIRE(2)+1
	SI nb=2 ALORS
		//changement de nom si nécessaire
		echange<-NomJ1
		NomJ1<-NomJ2
		NomJ2<-echange
	FINSI
	//demande de sélection de symbole au joueur 1
	REPETER
		ECRIRE NomJ1&('Veuillez choisir votre symbole X ou O')
		LIRE CarJ1
	JUSQU'A CarJ1='X' ou CarJ1='O'
	//attribution de l'autre symbole au joueur 2
	SI CarJ1='X' ALORS
		CarJ2='O'
	SINON
		CarJ2='X'
	FINSI
FINPROCEDURE

procedure affiche_Grille(G:grille)
//BUT afficher le contenu d'une grille
//ENTREE la grille
//SORTIE son contenu
DEBUT
	//affichage de chaque ligne de la grille
	ECRIRE G[1,1]&"|"&G[2,1]&"|"&G[3,1]
	ECRIRE"-+-+-"
	ECRIRE G[1,2]&"|"&G[2,2]&"|"&G[3,2]
	ECRIRE"-+-+-"
	ECRIRE G[1,3]&"|"&G[2,3]&"|"&G[3,3]
FINPROCEDURE

fonction verif(G:grille,C:caractère):booleen
//BUT vérifier la victoire d'un des joueurs
//ENTREE le caractère correspondant au joueur et grille de jeu
//SORTIE Vrai ou Faux
var
	test:BOOLEEN
DEBUT
	//initialisation
	test<-Faux
	//vérification de la présence de 3 symboles aligné
	SI G[1,1]=C ET G[1,2]=C ET G[1,3]=C ALORS
		test<-Vrai
	FINSI
	SI G[2,1]=C ET G[2,2]=C ET G[2,3]=C ALORS
		test<-Vrai
	FINSI
	SI G[3,1]=C ET G[3,2]=C ET G[3,3]=C ALORS
		test<-Vrai
	FINSI
	SI G[1,1]=C ET G[2,1]=C ET G[3,1]=C ALORS
		test<-Vrai
	FINSI
	SI G[1,2]=C ET G[2,2]=C ET G[3,2]=C ALORS
		test<-Vrai
	FINSI
	SI G[1,3]=C ET G[2,3]=C ET G[3,3]=C ALORS
		test<-Vrai
	FINSI
	SI G[1,1]=C ET G[2,2]=C ET G[3,3]=C ALORS
		test<-Vrai
	FINSI
	SI G[1,3]=C ET G[2,2]=C ET G[3,1]=C ALORS
		test<-Vrai
	FINSI
	//renvoi de test
	verif<-test
FINFONCTION

var
	G_de_Jeu:grille
	fin,cpt,ScoreJ1,ScoreJ2,tour,x,y:ENTIER
	NomJ1,NomJ2,ch:chaine
	C1,C2:caractère
	test,testF,ver:booleen
	f:text
	tdebut:TTime
DEBUT
	ECRIRE"Programme du Morpion"
	//initialisation des variables
	assigner(f,'Morpion.txt')
	ScoreJ1<-0
	ScoreJ2<-0
	cpt<-0
	tour<-1
	initGrille(G_de_Jeu)
	REPETER
		ECRIRE"Combien de parties voulez-vous faire ?"
		LIRE fin
		ECRIRE"Etes-vous sûr ? (oui ou non)"
		LIRE(ch)
	JUSQU'A fin>0 ET ch='oui'
	tdebut<-Time
	init_part(NomJ1,NomJ2,C1,C2)
	//début de la partie
	REPETER
		//initialisation d'une manche
		test<-faux
		initGrille(G_de_Jeu)
		tour<-1
		REPETER
			ver<-vrai
			//tour du joueur 1
			SI tour MOD 2<>0 ALORS
				ECRIRE"Tour de "&NomJ1
				//affichage de la grille
				affiche_Grille(G_de_Jeu)
				REPETER
					//demande d'une case et assignation du symbole si case valide
					REPETER
						SI ver=faux ALORS
							ECRIRE"Veuillez entrer une valeur valide."
						FINSI
						ECRIRE"Veuillez entrer une case : (colonne puis ligne entre 1 et 3)"
						LIRE(x)
						LIRE(y)
						SI (x<1) OU (x>3) OU (y<1) OU (y>3) ALORS
							ver<-faux
						FINSI
					JUSQU'A (x>0) ET (x<4) ET (y>0) ET (y<4)
					test<-Vrai
					SI G_de_Jeu[x,y]<>' ' ALORS
						test<-faux
						ECRIRE"Case déjà occupée"
					SINON
						G_de_Jeu[x,y]<-C1
					FINSI
				JUSQU'A test=Vrai
				//si plus de 5 coups alors on vérifie si le joueur gagne
				SI tour>=5 ALORS
					testF<-verif(G_de_Jeu,C1)
				FINSI
			SINON
				//tour du joueur 2
				ECRIRE"Tour de "&NomJ2
				//affichage de la grille
				affiche_Grille(G_de_Jeu)
				REPETER
					//demande d'une case et assignation du symbole si case valide
					REPETER
						SI ver=faux ALORS
							ECRIRE"Veuillez entrer une valeur valide."
						FINSI
						ECRIRE"Veuillez entrer une case : (colonne puis ligne entre 1 et 3)"
						LIRE(x)
						LIRE(y)
						SI (x<1) OU (x>3) OU (y<1) OU (y>3) ALORS
							ver<-faux
						FINSI
					JUSQU'A (x>0) ET (x<4) ET (y>0) ET (y<4)
					test<-Vrai
					SI G_de_Jeu[x,y]<>' ' ALORS
						test<-faux
						ECRIRE"Case déjà occupée"
					SINON
						G_de_Jeu[x,y]<-C2
					FINSI
				JUSQU'A test=Vrai
				//si plus de 5 coups alors on vérifie s le joueur gagne
				SI tour>=5 ALORS
					testF<-verif(G_de_Jeu,C2)
				FINSI
			FINSI
			//incrémentation du nombre de tour
			tour<-tour+1
		//jusqu'a la fin de la manche
		JUSQU'A testF=Vrai ou tour=10
		//vérification et augmentation des score
		SI test=vrai alors
			SI tour MOD 2<>0 ALORS
				ECRIRE"Joueur 2 gagne"
				ScoreJ2<-ScoreJ2+1
			SINON
				ECRIRE"Joueur 1 gagne"
				ScoreJ1:=ScoreJ1+1
			FINSI
		SINON
			ECRIRE"Match nul"
		FINSI
		//augmentation du nombre de manches jouées
		cpt<-cpt+1
		//vérification de l'existence du fichier
		$I-
		ouvrir(f)
		$I+
		SI (IOResult <> 0) ALORS
			//si il n'existe pas on le crait
			reecrire(f)
			//si c'est la première manche alors
			SI cpt=1 ALORS
				//on indique la date, l'heure de début de la partie ainsi que le nom des joueurs
				ch<-'Partie du :'+DateTimeToStr(Date)
				ECRIRE(f,ch)
				ch<-'Heure de début de la partie :'+TimeToStr(tdebut)
				ECRIRE(f,ch)
				ch<-'Joueur 1 :'+NomJ1
				ECRIRE(f,ch)
				ch<-'Joueur 2 :'+NomJ2
				ECRIRE(f,ch)
			FINSI
			//récapitulatif de la manche
			ch<-'Manche numéro : '+inttostr(cpt)
			ECRIRE(f,ch)
			ch<-'Gagnant : '
			SI tour MOD 2<>0 ALORS
				ch<-ch+NomJ2
			SINON
				ch<-ch+NomJ1
			FINSI
			ECRIRE(f,ch)
			ch<-'En '+inttostr(tour-1)+' coups.'
			ECRIRE(f,ch)
			//Si c'est la dernière manche alors
			SI cpt=fin ALORS
				//on indique l'heure de fin de la partie ainsi que le gagnant
				ch<-'Heure de fin de la partie :'+TimeToStr(Time)
				ECRIRE(f,ch)
				ch<-'Gagnant : '
				SI ScoreJ1>ScoreJ2 ALORS
					ch<-ch+NomJ1
				SINON
					SI ScoreJ2>ScoreJ1 ALORS
						ch<-ch+NomJ2
					SINON
						ch<-'Match nul.'
					FINSI
				FINSI
				ECRIRE(f,ch)
			FINSI
			FERMER(f)
		SINON
			//idem que précédement mais sans créer le fichier
			AJOUTER(f)
			SI cpt=1 ALORS
				ch<-'Partie du :'+DateTimeToStr(Date)
				ECRIRE(f,ch)
				ch<-'Heure de début de la partie :'+TimeToStr(tdebut)
				ECRIRE(f,ch)
				ch<-'Joueur 1 :'+NomJ1
				ECRIRE(f,ch)
				ch<-'Joueur 2 :'+NomJ2
				ECRIRE(f,ch)
			FINSI
			ch<-'Manche numéro : '+inttostr(cpt)
			ECRIRE(f,ch)
			ch<-'Gagnant : '
			SI tour MOD 2<>0 ALORS
				ch<-ch+NomJ2
			SINON
				ch<-ch+NomJ1
			FINSI
			ECRIRE(f,ch)
			ch<-'En '+inttostr(tour-1)+' coups.'
			ECRIRE(f,ch)
			SI cpt=fin ALORS
				ch<-'Heure de fin de la partie :'+TimeToStr(Time)
				ECRIRE(f,ch)
				ch<-'Gagnant : '
				SI ScoreJ1>ScoreJ2 ALORS
					ch<-ch+NomJ1
				SINON
					SI ScoreJ2>ScoreJ1 ALORS
						ch<-ch+NomJ2;
					SINON
						ch<-'Match nul.'
					FINSI
				FINSI
				ECRIRE(f,ch)
			FINSI
			FERMER(f)
		FINSI
	JUSQU'A cpt=fin
	//indication des scores de chaque joueur
	ECRIRE"Score du joueur 1 : "&ScoreJ1
	ECRIRE"Score du joueur 2 : "&ScoreJ2
	//indication de quel joueur gagne
	SI ScoreJ1>ScoreJ2 ALORS
		ECRIRE"Le Joueur 1 a gagné"
	SINON
		SI ScoreJ1<ScoreJ2 ALORS
			ECRIRE"Le Joueur 2 a gagné"
		SINON
			ECRIRE"Match nul."
		FINSI
	FINSI
	ECRIRE"A bientôt."
FIN}


//Programme morpion
//BUT créer un morpion
//ENTREE nombre de parties, case choisi et joueur X ou O
//SORTIE victoire de l'un des joueurs

//création du type grille
type grille=array[1..3,1..3] of char;

//procedures et fonctions
procedure initGrille(var G:grille);
//BUT initialiser une grille
//ENTREE une Grille
//SORTIE la grille initialiser
var
	i,j:integer;
BEGIN
	FOR i:=1 TO 3 DO
		begin
			FOR J:=1 TO 3  DO
				begin
					G[i,j]:=' ';
				end;
		end;
END;

procedure init_part(var NomJ1:string;var NomJ2:string;var CarJ1:char;var CarJ2:char);
//BUT initialiser le jeu
//ENTREE noms des joueurs et le caractère leur correspondant
//SORTIE jeu initialisé
var
	nb:integer;
	echange,ch:string;
BEGIN
	//demande du nom du joueur 1
	REPEAT
		writeln('Veuillez entrer le nom du joueur 1 :');
		readln(NomJ1);
		writeln();
		writeln(UTF8ToAnsi('Etes-vous sûr ? (oui ou non)'));
		readln(ch);
	UNTIL (NomJ1<>'') and (ch='oui');
	writeln();
	//demande du nom du joueur 2
	REPEAT
		writeln('Veuillez entrer le nom du joueur 2 :');
		readln(NomJ2);
		writeln();
		writeln(UTF8ToAnsi('Etes-vous sûr ? (oui ou non)'));
		readln(ch);
	UNTIL (NomJ2<>'') and (ch='oui') and (NomJ1<>NomJ2);
	writeln();
	//selection aléatoire du joueur jouant en premier
	randomize;
	nb:=random(2)+1;
	IF nb=2 THEN
		begin
			//changement de nom si nécessaire
			echange:=NomJ1;
			NomJ1:=NomJ2;
			NomJ2:=echange;
		end;
	//demande de sélection de symbole au joueur 1
	REPEAT
		writeln(NomJ1,' veuillez choisir votre symbole X ou O');
		readln(CarJ1);
	UNTIL (CarJ1='X') or (CarJ1='O');
	writeln();
	//attribution de l'autre symbole au joueur 2
	IF CarJ1='X' THEN
		begin
			CarJ2:='O';
		end
	ELSE
		begin
			CarJ2:='X';
		end;
END;

procedure affiche_Grille(G:grille);
//BUT afficher le contenu d'une grille
//ENTREE la grille
//SORTIE son contenu
BEGIN
	//affichage de chaque ligne de la grille
	writeln(G[1,1],'|',G[2,1],'|',G[3,1]);
	writeln('-+-+-');
	writeln(G[1,2],'|',G[2,2],'|',G[3,2]);
	writeln('-+-+-');
	writeln(G[1,3],'|',G[2,3],'|',G[3,3]);
	writeln();
END;

function verif(G:grille;C:char):boolean;
//BUT vérifier la victoire d'un des joueurs
//ENTREE le caractère correspondant au joueur et grille de jeu
//SORTIE Vrai ou Faux
var
	test:boolean;
BEGIN
	//initialisation
	test:=False;
	//vérification de la présence de 3 symboles aligné
	IF (G[1,1]=C) AND (G[1,2]=C) AND (G[1,3]=C) THEN
		begin
			test:=True;
		end;
	IF (G[2,1]=C) AND (G[2,2]=C) AND (G[2,3]=C) THEN
		begin
			test:=True;
		end;
	IF (G[3,1]=C) AND (G[3,2]=C) AND (G[3,3]=C) THEN
		begin
			test:=True;
		end;
	IF (G[1,1]=C) AND (G[2,1]=C) AND (G[3,1]=C) THEN
		begin
			test:=True;
		end;
	IF (G[1,2]=C) AND (G[2,2]=C) AND (G[3,2]=C) THEN
		begin
			test:=True;
		end;
	IF (G[1,3]=C) AND (G[2,3]=C) AND (G[3,3]=C) THEN
		begin
			test:=True;
		end;
	IF (G[1,1]=C) AND (G[2,2]=C) AND (G[3,3]=C) THEN
		begin
			test:=True;
		end;
	IF (G[1,3]=C) AND (G[2,2]=C) AND (G[3,1]=C) THEN
		begin
			test:=True;
		end;
	//renvoi de test
	verif:=test;
END;

var
	G_de_Jeu:grille;
	fin,cpt,ScoreJ1,ScoreJ2,tour,x,y:integer;
	C1,C2:char;
	NomJ1,NomJ2,ch:string;
	test,testF,ver:boolean;
	f:TextFile;
	tdebut:TTime;
BEGIN
	//initialisation des variables
	Assign(f,'Morpion.txt');
	clrscr;
	writeln('Programme du Morpion :');
	writeln();
	//initialisation des variables
	ScoreJ1:=0;
	ScoreJ2:=0;
	cpt:=0;
	tour:=1;
	initGrille(G_de_Jeu);
	REPEAT
		writeln('Combien de parties voulez-vous faire ?');
		readln(fin);
		writeln();
		writeln(UTF8ToAnsi('Etes-vous sûr ? (oui ou non)'));
		readln(ch);
		writeln();
	UNTIL (fin>0) AND (ch='oui');
	init_part(NomJ1,NomJ2,C1,C2);
	tdebut:=time;
	//début de la partie
	REPEAT
		//initialisation d'une manche
		testF:=false;
		initGrille(G_de_Jeu);
		tour:=1;
		REPEAT
			ver:=true;
			IF tour MOD 2<>0 THEN
				begin
					//tour du joueur 1
					writeln('Tour de ',NomJ1);
					writeln();
					//affichage de la grille
					affiche_Grille(G_de_Jeu);
					REPEAT
						//demande d'une case et assignation du symbole si case valide
						REPEAT
							if ver=false then
								begin
									writeln('Veuillez entrer une valeur valide.');
									writeln();
								end;
							writeln('Veuillez entrer une case : (colonne puis ligne entre 1 et 3)');
							readln(x);
							readln(y);
							if (x<1) OR (x>3) OR (y<1) OR (y>3) then
								begin
									ver:=false;
								end;
						UNTIL (x>0) AND (x<4) AND (y>0) AND (y<4);
						test:=True;
						IF G_de_Jeu[x,y]<>' ' THEN
							begin
								test:=false;
								writeln(UTF8ToAnsi('Case déjà occupée.'));
							end
						ELSE
							begin
								G_de_Jeu[x,y]:=C1;
							end;
					UNTIL test=True;
					//si plus de 5 coups alors on vérifie si le joueur gagne
					IF tour>=5 THEN
						begin
							testF:=verif(G_de_Jeu,C1);
						end;
					writeln();
				end
			ELSE
				begin
					//tour du joueur 2
					writeln('Tour de ',NomJ2);
					writeln();
					//affichage de la grille
					affiche_Grille(G_de_Jeu);
					REPEAT
						//demande d'une case et assignation du symbole si case valide
						REPEAT
							if ver=false then
								begin
									writeln('Veuillez entrer une valeur valide.');
									writeln();
								end;
							writeln('Veuillez entrer une case : (colonne puis ligne entre 1 et 3)');
							readln(x);
							readln(y);
							if (x<1) OR (x>3) OR (y<1) OR (y>3) then
								begin
									ver:=false;
								end;
						UNTIL (x>0) AND (x<4) AND (y>0) AND (y<4);
						test:=True;
						IF G_de_Jeu[x,y]<>' ' THEN
							begin
								test:=False;
								writeln(UTF8ToAnsi('Case déjà occupée.'));
							end
						ELSE
							begin
								G_de_Jeu[x,y]:=C2;
							end;
					UNTIL test=True;
					//si plus de 5 coups alors on vérifie s le joueur gagne
					IF tour>=5 THEN
						begin
							testF:=verif(G_de_Jeu,C2);
						end;
					writeln();
				end;
			//incrémentation du nombre de tour
			tour:=tour+1;
		//jusqu'a la fin de la manche
		UNTIL (testF=True) or (tour=10);
		//vérification et augmentation des score
		IF testF=True then
			begin
				IF tour MOD 2<>0 THEN
					begin
						writeln('Joueur 2 gagne');
						ScoreJ2:=ScoreJ2+1;
						writeln();
					end
				ELSE
					begin
						writeln('Joueur 1 gagne');
						ScoreJ1:=ScoreJ1+1;
						writeln();
					end;
			end
		ELSE
			begin
				writeln('Match nul');
				writeln();
			end;
		//augmentation du nombre de manches jouées
		cpt:=cpt+1;
		//vérification de l'existence du fichier
		{$I-}
		Reset(f);
		{$I+}
		IF (IOResult <> 0) THEN
			begin
				//si il n'existe pas on le crait
				rewrite(f);
				//si c'est la première manche alors
				if cpt=1 then
					begin
						//on indique la date, l'heure de début de la partie ainsi que le nom des joueurs
						ch:='Partie du :'+DateTimeToStr(Date);
						writeln(f,ch);
						writeln(f);
						ch:='Heure de début de la partie :'+TimeToStr(tdebut);
						writeln(f,ch);
						writeln(f);
						ch:='Joueur 1 :'+NomJ1;
						writeln(f,ch);
						ch:='Joueur 2 :'+NomJ2;
						writeln(f,ch);
						writeln(f);
					end;
				//récapitulatif de la manche
				ch:='Manche numéro : '+inttostr(cpt);
				writeln(f,ch);
				writeln(f);
				ch:='Gagnant : ';
				IF tour MOD 2<>0 THEN
					begin
						ch:=ch+NomJ2;
					end
				ELSE
					begin
						ch:=ch+NomJ1;
					end;
				writeln(f,ch);
				ch:='En '+inttostr(tour-1)+' coups.';
				writeln(f,ch);
				writeln(f);
				//Si c'est la dernière manche alors
				if cpt=fin then
					begin
						//on indique l'heure de fin de la partie ainsi que le gagnant
						ch:='Heure de fin de la partie :'+TimeToStr(Time);
						writeln(f,ch);
						writeln(f);
						ch:='Gagnant : ';
						IF ScoreJ1>ScoreJ2 THEN
							begin
								ch:=ch+NomJ1;
							end
						ELSE
							begin
								if ScoreJ2>ScoreJ1 then
									begin
										ch:=ch+NomJ2;
									end
								else
									begin
										ch:='Match nul.'
									end;
							end;
						writeln(f,ch);
						writeln(f);
						writeln(f);
					end;
				close(f);
			end
		else
			begin
				//idem que précédement mais sans créer le fichier
				append(f);
				if cpt=1 then
					begin
						ch:='Partie du :'+DateTimeToStr(Date);
						writeln(f,ch);
						writeln(f);
						ch:='Heure de début de la partie :'+TimeToStr(tdebut);
						writeln(f,ch);
						writeln(f);
						ch:='Joueur 1 :'+NomJ1;
						writeln(f,ch);
						ch:='Joueur 2 :'+NomJ2;
						writeln(f,ch);
						writeln(f);
					end;
				ch:='Manche numéro : '+inttostr(cpt);
				writeln(f,ch);
				writeln(f);
				ch:='Gagnant : ';
				IF tour MOD 2<>0 THEN
					begin
						ch:=ch+NomJ2;
					end
				ELSE
					begin
						ch:=ch+NomJ1;
					end;
				writeln(f,ch);
				ch:='En '+inttostr(tour-1)+' coups.';
				writeln(f,ch);
				writeln(f);
				if cpt=fin then
					begin
						ch:='Heure de fin de la partie :'+TimeToStr(Time);
						writeln(f,ch);
						writeln(f);
						ch:='Gagnant : ';
						IF ScoreJ1>ScoreJ2 THEN
							begin
								ch:=ch+NomJ1;
							end
						ELSE
							begin
								if ScoreJ2>ScoreJ1 then
									begin
										ch:=ch+NomJ2;
									end
								else
									begin
										ch:='Match nul.'
									end;
							end;
						writeln(f,ch);
						writeln(f);
						writeln(f);
					end;
				close(f);
			end;
	UNTIL cpt=fin;
	//indication des scores de chaque joueur
	writeln('Score du joueur 1 : ',ScoreJ1);
	writeln();
	writeln('Score du joueur 2 : ',ScoreJ2);
	writeln();
	//indication de quel joueur gagne
	IF ScoreJ1>ScoreJ2 THEN
		begin
			writeln(UTF8ToAnsi('Le Joueur 1 a gagné'));
		end
	ELSE
		begin
			IF ScoreJ1<ScoreJ2 THEN
				begin
					writeln(UTF8ToAnsi('Le Joueur 2 a gagné'));
				end
			ELSE
				begin
					writeln('Match nul.');
				end;
		end;
	writeln();
	writeln(UTF8ToAnsi('A bientôt.'));
	readln;
END.
