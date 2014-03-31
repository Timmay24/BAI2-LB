% Autor: %AUTHOR%
% Datum: %DATE%

% AUFGABE 1 %

% Teil 1.1
is_a_list([_|_]).
% Teil 1.2
app([],L,L).
app([KopfL1|RestL1],L2,[KopfL1|RestL3]) :- app(RestL1,L2,RestL3).

% Teil 1.3
infix(I,[I|_]).
infix(I,[_|Rest]) :- infix(I,Rest).

% Teil 1.4
suffix(S,[S|[]]).
suffix(S,[_|Rest]) :- suffix(S,Rest).

% Teil 1.5
prefix(P,[P|_]).

% Teil 1.6
%        List Even Odd
eo_count([],  0,   0  ).

% Zählt Elemente einer Liste %
elem_count([],0).
elem_count([_|Rest],Accu) :- elem_count(Rest,NewAccu), Accu is NewAccu + 1.

% Teil 1.7
del_element(_E,[],[]).
del_element(E,[LK|LR],[RK|RR]).


% Teil 1.8
substitute(_E1,_E2,[],[]).                                        /*
substitute(E1,E2,[LK|LR],[|RR]) :- substitute(E1,E2,LR,RR),LK=E1. */


% Teil 2.1
a21(OutDEPTNO, OutDNAME) :- dept(OutDEPTNO, OutDNAME, 'BOSTON').

% Teil 2.2
a22(DNAME,EMPNO,ENAME) :-
    dept(DEPTNO,DNAME,_LOC),
    emp(EMPNO,ENAME,_JOB,_MGR,_SAL,_EXT,DEPTNO).

% Teil 2.3
a23(OutENAME) :- emp(_EMPNO,OutENAME,'PRESIDENT',_MGR,_SAL,_EXT,_DEPTNO).
a23(OutENAME) :- emp(_EMPNO,OutENAME,'MANAGER',_MGR,_SAL,_EXT,_DEPTNO).

% Teil 2.4
a24(OutENAME) :-
    emp(_,OutENAME,_,MGR,ESAL,_,_),emp(MGR,_,_,_,MSAL,_,_),ESAL > MSAL.

% Teil 2.5
a25(MGRNAME,OutENAME) :-
    emp(EMPNO,MGRNAME,_,_,_,_,_), emp(EMPNO2,OutENAME,_,EMPNO,_,_,_).


%emp(EMPNO,MGRNAME,_,_,_,_,_), emp(_,ENAME,_,EMPNO,_,_,_).