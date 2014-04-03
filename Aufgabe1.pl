
% AUFGABE 1 %

% Teil 1.1)
is_a_list([]).     % Eingabe ist eine leere Liste
is_a_list([_|_]).  % Eingabe ist eine Liste beliebiger Länge

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 1.2)
% app(Liste 1, Liste 2, Ergebnisliste)
app([],List,List).                         % Basisfall, Liste 2 mit Ergebnisliste unifizieren
app([KopfL1|RestL1],L2,[KopfL1|RestL3]) :- % Ergebnisliste auf Rückweg um Kopf von L1 erweitern
    app(RestL1,L2,RestL3).                 % Rek. Aufruf, um zum Ende von L1 zu gelangen
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 1.3)
infix(I,[I|_]).                     % Rek.Abbruch, Element I ist in der Liste enthalten
infix(I,[_|Rest]) :- infix(I,Rest). % Rek. Aufruf, Rest der Liste übergeben und weitersuchen

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 1.4)
suffix(S,[S|[]]).                     % Rek.Abbruch, Element steht am Ende der Liste
suffix(S,[_|Rest]) :- suffix(S,Rest). % Rek. Aufruf, Rest übergeben

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 1.5)
prefix(P,[P|_]).  % Position: Anfang der Liste und P ist Kopf der Liste,
                  % somit ist das Element P Präfix der Liste.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 1.6)
% eo_count(Eingabeliste L, Zähler geradestelliger Listen Even, Zähler ungeradestell. Listen Odd)
eo_count([],0,0).       % Basisfall, Rek.Abbruch


% Zählt Elemente einer Liste %
elem_count([],0).
elem_count([_|Rest],Accu) :- elem_count(Rest,NewAccu), Accu is NewAccu + 1.
% Gibt Auskunft darüber, ob die Anzahl Elemente der Liste L gerade ist %
list_even?(L) :- elem_count(L,Count), 0 is mod(Count,2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Teil 1.7)
% del_element(Zu löschendes Element E, Eingabeliste L, Ergebnisliste R)
del_element(_E,[],[]).                % Basisfall, Rek.-Abbruch
del_element(E,[E|L_Rest],R) :-        % Ist E mit dem Kopf der Liste L unifizierbar
    del_element(E,L_Rest,R).          % => Ergebnisliste R ohne E "weitergeben"
                                      % andernfalls
del_element(E,[L_Kopf|L_Rest],Out) :- % Liste R mit L-Kopf gebunden an Out
    del_element(E,L_Rest,R_Rest),     % Rekursiver Aufruf (result. Liste R auf Rückweg)
    Out = [L_Kopf|R_Rest].            % Liste R mit L-Kopf aufbauen und an Out binden

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 1.8)
% substitute(Element1, Element2, Liste L, Ergebnisliste R)
substitute(_E1,_E2,[],[]).          % Basisfall, Rek.Abbruch, R mit [] unifizieren
substitute(E1,E2,[E1|L_Rest],[E2|R_Rest]) :- % E1 ist Kopf von L, auf d. Rückweg wird R
                                             % unifiziert mit R_Rest und E2 als neuer Kopf
    substitute(E1,E2,L_Rest,R_Rest).         % Rek. Aufruf bis Listenende
    
substitute(E1,E2,[L_First|L_Rest],[L_First|R_Rest]) :- % E1 ist nicht Kopf von L, daher wird auf d. Rückweg
                                                       % R unifiziert mit R_Rest und dem Kopf von L
    substitute(E1,E2,L_Rest,R_Rest).                   % Rek. Aufruf bis Listenende

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 2.1)
a21 :- dept(DEPTNO, DNAME, 'BOSTON'),            % Passende Werte zu Boston an Variablen binden
    write('DeptNo: '), write(DEPTNO),            % Ausgabe Deptno
    write(', DeptName: '), writeln(DNAME), fail. % Ausgabe DeptName
a21.                                             % Rückgabe von false durch fail abfangen

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 2.2)
a22 :- a22('RESEARCH').
a22(DNAME) :-
    dept(DEPTNO,DNAME,_LOC),                     % Dept.Nummer zum Dept.Namen finden
    emp(EMPNO,ENAME,_JOB,_MGR,_SAL,_EXT,DEPTNO), % Mitarbeiter ermitteln
    write('EmpNo: '), write(EMPNO),              % Ausgabe EMPNO
    write(', EmpName: '), writeln(ENAME), fail.  % Ausgabe ENAME
a22(_DNAME).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 2.3)
a23 :- emp(_EMPNO,ENAME,'PRESIDENT',_MGR,_SAL,_EXT,_DEPTNO), % Präsidenten suchen
    write('President: '), writeln(ENAME), fail.              % Job + Namen Ausgabe
    
a23 :- emp(_EMPNO,ENAME,'MANAGER',_MGR,_SAL,_EXT,_DEPTNO),   % Mananger suchen
    write('Manager:   '), writeln(ENAME), fail.              % Job + Namen Ausgabe
a23.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 2.4)
a24 :- emp(_EMPNO,ENAME,_EJOB,MGR,ESAL,_EEXT,_EDEPTNO), % Mitarbeiter samt Gehalt und Vorgesetzten laden
    emp(MGR,MGRNAME,_MJOB,_MGR,MSAL,_MEXT,_MDEPTNO),    % Vorgesetzten des MA samt Gehalt laden
                                        ESAL > MSAL,    % Gehalt des MA > Gehalt des Vorgesetzten?
    write(ENAME), write(' verdient mehr als sein Vorgesetzter '), writeln(MGRNAME), fail.
a24.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teil 2.5)
a25 :- a25('JONES').
a25(MGRNAME) :-                                          % a25(Name des Managers)
    emp(MGRNO,MGRNAME,_MJOB,_MMGR,_MSAL,_MEXT,_MDEPTNO), % Angestelltennummer des Managers ermitteln
    emp(EMPNO,EMPNAME,_EJOB,MGRNO,_ESAL,_EEXT,_EDEPTNO), % Unterstellten des Managers suchen
    a25(EMPNAME),                                        % Rek. Aufruf zur Suche nach indirekt Unterstellten
    write(EMPNAME), write(' ist '), write(MGRNAME), writeln(' unterstellt.'), fail.
a25(_MGRNAME).                                           % false durch fail abfangen
a25.                                                     % dito





/**************************/
%                          %
% Datenbank aus empdept.pl %
%                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%emp(EMPNO, ENAME,   JOB,        MGR,  SAL,  EXT,  DEPTNO).
emp(7654, 'MARTIN', 'SALESMAN',  7698, 1250, 1400, 30).
emp(7499, 'ALLEN',  'SALESMAN',  7698, 1600,  300, 30).
emp(7844, 'TURNER', 'SALESMAN',  7698, 1500,    0, 30).
emp(7521, 'WARD',   'SALESMAN',  7698, 1250,  500, 30).
emp(7839, 'KING',   'PRESIDENT', null, 5000, null, 10).
emp(7698, 'BLAKE',  'MANAGER',   7839, 2850, null, 30).
emp(7782, 'CLARK',  'MANAGER',   7839, 2450, null, 10).
emp(7566, 'JONES',  'MANAGER',   7839, 2975, null, 20).
emp(7900, 'JAMES',  'CLERK',     7698, 950,  null, 30).
emp(7902, 'FORD',   'ANALYST',   7566, 3000, null, 20).
emp(7369, 'SMITH',  'CLERK',     7902, 800,  null, 20).
emp(7788, 'SCOTT',  'ANALYST',   7566, 3000, null, 20).
emp(7876, 'ADAMS',  'CLERK',     7788, 1100, null, 20).
emp(7934, 'MILLER', 'CLERK',     7782, 1300, null, 10).

%dept(DEPTNO, DNAME,   LOC).
dept(10, 'ACCOUNTING', 'NEW YORK').
dept(20, 'RESEARCH',   'DALLAS').
dept(30, 'SALES',      'CHICAGO').
dept(40, 'OPERATIONS', 'BOSTON').