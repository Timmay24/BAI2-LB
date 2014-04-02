%delDup(Eingabe,Ausgabe)
delDup(Eingabe,Ausgabe) :- delDup(Eingabe,[],Ausgabe).
%delDup(Eingabe,Accu,Ausgabe)
delDup(ToDo,Done,Output) :-
          [Kopf|Rest] = ToDo,
          member(Kopf,Done), %Ist Kopf Zweites Vorkommen?
          delDup(Rest,Done,Output).
delDup(ToDo,Done,Output) :-
          [Kopf|Rest] = ToDo,
          not(member(Kopf,Done)), %Ist Kopf Erstes Vorkommen?
          Output = [Kopf|OutputRest],
          delDup(Rest,[Kopf|Done],OutputRest).
delDup(ToDo,_Done,Output) :-
          [] = ToDo,
          Output = [].
delDupLast([],Out) :- Out =[].
delDupLast([K|R],Out) :-
            %member(K,R),
            delDupLast(R,ROut),
            member(K,ROut),
            Out= ROut.
delDupLast([K|R],Out) :-
            delDupLast(R,ROut),
            not(member(K,ROut)),
            Out= [K|ROut].

delDupLast([K|R],Out) :-
            delDupLast(R,ROut),
            ((member(K,ROut),
              Out= ROut);
              not(member(K,ROut)),
              Out= [K|ROut]).


callPre([],[]).
callPre([K|R],[writeln(K)|CR]) :- callPre(R,CR).
evalB([]).
evalB([Kopf|EingabeRest]) :-
         Kopf, %eval(Kopf)
         evalB(EingabeRest).




%plusEins(EingabeListe,AusgabeListe)
%plusEins(Input,Output) :- Input = [],Output = [].
%plusEins(Input,Output) :- [] = Input,Output = [].
%plusEins(Input,Output) :- plusEins([],[]).rekursive Aufruf
%plusEins([],Output) :- Output = [].
plusEins([],[]).

/*plusEins([Kopf|EingabeRest],[Tmp|AusgabeRest]) :-
         Tmp is Kopf+1,
         plusEins(EingabeRest,AusgabeRest). */
plusEins([Kopf|EingabeRest],[Kopf+1|AusgabeRest]) :-
         plusEins(EingabeRest,AusgabeRest).

%evalA(InListe,OutListe)
evalA([],[]).
evalA([Kopf|EingabeRest],[Tmp|AusgabeRest]) :-
         Tmp is Kopf,
         evalA(EingabeRest,AusgabeRest).

/* plusEins([Kopf|EingabeRest],L2) :-
         plusEins(EingabeRest,AusgabeRest),
         L2 = [Kopf+1|AusgabeRest].
plusEins(Eingabe,Ausgabe) :-
         [Kopf|EingabeRest] = Eingabe,
         Ausgabe = [Kopf+1|AusgabeRest],
         plusEins(EingabeRest,AusgabeRest).
plusEins(Eingabe,Ausgabe) :-
         [Kopf|EingabeRest] = Eingabe,
         NeuesElement = Kopf+1,
         plusEins(EingabeRest,AusgabeRest),
         Ausgabe = [NeuesElement|AusgabeRest].
plusEins(Eingabe,Ausgabe) :-
         [Kopf|EingabeRest] = Eingabe,
         NeuesElement = Kopf+1,
         ,
         Ausgabe = [NeuesElement|plusEins(EingabeRest,AusgabeRest)].
                   */


/* Enthaltensein in einer Liste */
contains([Kopf|_],Kopf).
contains([_|Rest],Element) :- contains(Rest,Element).

auswerten(X) :- X.
beispiel(_X) :- writeln('--').

/* Die Kloetzchenwelt - Teil 1 */
block(block1).
block(block2).
block(block3).
block(block4).
tisch(tisch).
/* auf(X,Y): X ist auf Y */
auf(block3,block1). 
auf(block4,block2).
auf(block1,tisch).
auf(block2,tisch).

/* oberhalb(X,Y): X ist oberhalb Y */
oberhalb(X,Y) :- auf(X,Y).
oberhalb(X,Z) :- auf(X,Y),oberhalb(Y,Z).

/* Abarbeitungsstrategie */
a :- d.
d.
%d:-true.
b :- d.

/* Endlosschleife */
p(X) :- q(X).
q(X) :- p(X).
q(a).

/* konk(<Liste 1>,<Liste 2>,<Konkatenation von Liste 1 und Liste 2>) */
konk([],List,List).
konk([X|List1],List2,[X|List3]) :- konk(List1,List2,List3).


/* ==================================================================
 Der Cut
===================================================================*/
f1(X,Out) :- X < 3, Out = 0.
f1(X,0) :- X < 3.
f1(X,2) :- 3 =< X, X < 6.
f1(X,4) :- 6 =< X.




f2(X,0) :- X < 3,!.
f2(X,2) :- 3 =< X, X < 6,!.
f2(X,4) :- 6 =< X.

f3(X,0) :- X < 3,!.
f3(X,2) :- X < 6,!.
f3(_,4).

/* ==================================================================
 Der Cut: Test
===================================================================*/
linksVcut :- write('lvc-1 ').
linksVcut :- write('lvc-2 ').
rechtsVcut :- write('rvc-1 ').
rechtsVcut :- write('rvc-2 ').
testAcut :- write('1A- '),linksVcut,write('2A- '),!,rechtsVcut,write('3A- '),fail.
testAcut :- writeln(' -4A.').
testBcut :- write('1B- '),linksVcut,write('2B- '),rechtsVcut,write('3B- '),fail.
testBcut :- writeln(' -4B.').

/* ==================================================================
 Negation
===================================================================*/
ungleich(X, X) :- !, fail.
ungleich(_, _).

not1(X) :- X, !, fail.
not1(_).

/* ==================================================================
 Closed World Assumption
===================================================================*/
p1(b) :- not(q1(a)).
q1(a).

r2(a) :- not(q2(X)),p2(X).
q2(a).
p2(b).

r3(a) :- p3(X),not(q3(X)).
q3(a).
p3(b).

addj([],[]).
addj([K|RestIn_Liste],[K + 1|Out_Liste]) :- NK is K + 1,
                                    addj(RestIn_Liste,Out_Liste).


% Initialisierung
addi(In_Liste,Out_Liste) :-
  addi(In_Liste,[],Out_Liste).

% Rekursionsabbruch
% Akku_Liste = Out_Liste
addi([],Akku_Liste,Out):- reverse(Akku_Liste,Out).
addi([],Akku_Liste,Akku_Liste).
addi([],Akku_Liste,Out) :- Out = Akku_Liste.

% Rekursionsschritt
addi([K|R],Akku_Liste,Out_Liste):-
 NK is K + 1, % Schritt
 addi(R,[NK|Akku_Liste],Out_Liste).

/* ==================================================================
 Listen
===================================================================*/
% drehen/2 (reverse)
drehen(Liste,GedrehteL) :- drehen(Liste,[],GedrehteL).
%drehen/3
drehen([],Liste,Liste).
drehen([X|Rest],Liste,Erg) :- drehen(Rest,[X|Liste],Erg).

/* ==================================================================
 Tiefensuche
===================================================================*/
% Tuerme von Hanoi
hanoi(N) :- move(N,left,middle,right).

% Spielregeln/-strategie
move(0,_,_,_) :- !.
move(I,Q,Z,Tmp) :- J is I - 1,
                             move(J,Q,Tmp,Z),
                             inform(Q,Z),
                             move(J,Tmp,Z,Q).

% Ausgabe Funktion
inform(X,Y) :- write([move,a,disc,from,the,X,pole,to,the,Y,pole]),nl.  

/* ==================================================================
 Sortieren
===================================================================*/
% bubblesort/2
bubblesort(ListeIN, ListeOUT) :- findePaar(ListeIN,ListeZW),!,bubblesort(ListeZW,ListeOUT).
bubblesort(ListeOUT,ListeOUT).

% findePaar/2
findePaar([X,Y|Rest],[Y,X|Rest]) :- X >= Y.                                 
findePaar([X|RestIN],[X|RestZW]) :- findePaar(RestIN,RestZW).

% quicksort/2
quicksort([],[]).
quicksort([X|Liste],Resultat) :- teileAuf(Liste,X,Kleiner,Groesser),
                                 quicksort(Kleiner,KleinerOK),
                                 quicksort(Groesser,GroesserOK),
                                 konk(KleinerOK,[X|GroesserOK],Resultat).
% teileAuf/4
teileAuf([],_,[],[]).
teileAuf([Y|Rest],X,[Y|Kleiner],Groesser) :- X >= Y,
                                             teileAuf(Rest,X,Kleiner,Groesser).
teileAuf([Y|Rest],X,Kleiner,[Y|Groesser]) :- X < Y,
                                             teileAuf(Rest,X,Kleiner,Groesser).

/* ==================================================================
 kleiner Graph
===================================================================*/
pfad(X,Y) :- kante(X,Y).
pfad(X,Y) :- kante(X,I), pfad(I,Y).
pfad(a,_).

kante(b,c).
kante(c,e).
kante(c,d).

/* ==================================================================
 3-12
===================================================================*/
 % $\forall x: ((V(x) \wedge G(x)) \rightarrow W(x))$
 w(X) :- v(X),g(X).
 % $\forall x: ((V(x) \wedge P(x,y)) \rightarrow V(y))$
 v(Y) :- v(X),p(X,Y).
 % $\forall x: ((\neg V(x) \wedge \neg G(x)) \rightarrow (\neg G(v(x)) \vee \neg G(m(x))))$
 % $\forall x: ((G(v(x)) \wedge G(m(x))) \rightarrow (V(x) \vee G(x)))$
 v(X) :- vFKT(X,_Out_v),g(_Out),mFKT(X,Out_m),g(Out_m).
 g(X) :- vFKT(X,_Out_v),g(_Out),mFKT(X,Out_m),g(Out_m).
 % $\forall x:((V(x)\wedge G(x)) \rightarrow (\exists y:(K(y,x))))$
 k(_Y,X) :- v(X),g(X).
 
 /* ==================================================================
 Schleifen
===================================================================*/
/*  a := 0; i := 0;
    while (i <= 10) do
      writeln(a);
      i := i+1; a := a+i;                                          */
whileSchleife(Ina,Ini) :- whileSchleife(0,0,Ina,Ini).
whileSchleife(Ina,Ini,Erga,Ergi) :- Ini =< 10,!, writeln(Ina), Outi is Ini + 1, Outa is Ina + Outi, whileSchleife(Outa,Outi,Erga,Ergi).
whileSchleife(Ina,Ini,Ina,Ini) :- Ini > 10.
/*  a := 0;
    for i := 0 to 10 do
      writeln(a);
      a := a+i;                                          */
forSchleife(Ina,Ini) :- forSchleife(0,10,0,Ina,Ini).
forSchleife(Ini,Max,Ina,Erga,Ergi) :- Ini =< Max,!, writeln(Ina), Outi is Ini + 1, Outa is Ina + Outi, forSchleife(Outi,Max,Outa,Erga,Ergi).
forSchleife(Ini,Max,Ina,Ina,Ini) :- Ini > Max.

fib(0,0).
fib(1,1).
fib(N,Num) :- NmE is N - 1, fib(NmE,Erg1),
              NmZ is N - 2, fib(NmZ,Erg2),
              Num is Erg1 + Erg2.
fibZahlen(Max,K,FibN,Liste,Sum,Erg) :-
                 Sum < Max, length(Liste,L), L < K,
                 Neu is FibN + 1,
                 fib(Neu,Out),
                 NeuSum is Sum + Out,
                 fibZahlen(Max,K,Neu,[Out|Liste],NeuSum,Erg).
fibZahlen(Max,K,FibN,Liste,Sum,Erg) :-
                 Sum < Max, length(Liste,L), L >= K,
                 Neu is FibN + 1,
                 fib(Neu,Out),
                 BackTrack is Neu - K,
                 fib(BackTrack,Abzug),
                 NeuSum is Sum + Out - Abzug,
                 deleteLast(Liste,NeuListe),
                 fibZahlen(Max,K,Neu,[Out|NeuListe],NeuSum,Erg).
fibZahlen(Max,_K,_FibN,Liste,Sum,Liste) :-
                 Sum >= Max.
fibZahlen(N,K,Liste) :- fibZahlen(N,K,-1,[],0,Liste).



fibk(K,N,0) :- N >= 0, NK is K - 2, NK >= N.
fibk(K,N,1) :- N is K - 1.
fibk(K,N,Num) :- sumfibk(N,K,Num). %n-1 bis n-k summieren

sumfibk(N,K,Num) :- sumfibk(N,K,1,0,Num).
sumfibk(N,K,K,Akku,Num) :- NBer is N - K,
                           fibk(K,NBer,Tmp),
                           Num is Akku + Tmp.
sumfibk(N,K,I,Akku,Num) :- NBer is N - I,
                           fibk(K,NBer,Tmp),
                           NeuAkku is Akku + Tmp,
                           NeuI is I + 1,
                           sumfibk(N,K,NeuI,NeuAkku,Num).

fibkZahlen(Max,K,FibN,Liste,Sum,Erg) :-
                 Sum < Max, length(Liste,L), L < K,
                 Neu is FibN + 1,
                 fibk(K,Neu,Out),
                 NeuSum is Sum + Out,
                 fibkZahlen(Max,K,Neu,[Out|Liste],NeuSum,Erg).
fibkZahlen(Max,K,FibN,Liste,Sum,Erg) :-
                 Sum < Max, length(Liste,L), L >= K,
                 Neu is FibN + 1,
                 fibk(K,Neu,Out),
                 BackTrack is Neu - K,
                 fibk(K,BackTrack,Abzug),
                 NeuSum is Sum + Out - Abzug,
                 deleteLast(Liste,NeuListe),
                 fibkZahlen(Max,K,Neu,[Out|NeuListe],NeuSum,Erg).
fibkZahlen(Max,_K,_FibN,Liste,Sum,Liste) :-
                 Sum >= Max.
fibkZahlen(N,K,Liste) :- fibkZahlen(N,K,-1,[],0,Liste).


deleteLast([_Last],[]).
deleteLast([X,Y|Rest],[X|Out]) :- deleteLast([Y|Rest],Out).
