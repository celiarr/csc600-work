%facts
m([liam,noah,oliver,benjamin,nick,henry,mack,banks,elio,tom]).
f([olivia,emma,sophia,mia,lia,harper,luna,camila]).

family([liam,olivia,[oliver,benjamin]]).
family([noah,emma,[sophia,mia]]).

/*kids of oliver/sophia and benjamin/mia*/
family([oliver,sophia,[luna,camila]]).
family([benjamin,mia,[mack,banks]]).
family([nick,lia,[henry,harper]]).

/*kids of mack and harper*/
family([mack,harper,[elio,tom]]).


%rules
female(F):- f(L),member(F,L).
male(M):- m(L),member(M,L).

parent(P,C):-family([F,M|[L]]),(P=F;P=M),member(C,L).
mother(M,C):-female(M),family([_,M1|[C1]]),(M=M1),member(C,C1).
father(F,C):-male(F),family([F1,_|[C1]]),(F=F1),member(C,C1).

siblings(S1,S2):-family([_,_|[L]]),member(S1,L),member(S2,L).
sisters(S1,S2):- female(S1),female(S2),family([_,_|[L]]),member(S1,L),member(S2,L).
brothers(B1,B2):-male(B1),male(B2),family([_,_|[L]]),member(B1,L),member(B2,L).


cousins(C1,C2):-parent(P1,C1),parent(P2,C2),siblings(P1,P2).
uncle(U,C):- male(U),parent(P,C),siblings(U,P).
aunt(A,C):-female(A),parent(P,C),siblings(A,P).

grandchild(C,P):-parent(P1,C),parent(P,P1).
grandson(C,P):-male(C),parent(P1,C),parent(P,P1).
granddaughter(C,P):-female(C),parent(P1,C),parent(P,P1).
greatgrandparent(C,P):-parent(P1,C),parent(P2,P1),parent(P,P2).
ancestor(P,C):- parent(P,C);greatgrandparent(C,P).

/***********************
example of rules

female(emma).
male(noah).

parent(liam,oliver).
mother(olivia,benjamin).
father(liam,oliver).

siblings(sophia,mia).
sisters(sophia,mia).
brothers(mack, banks).


cousins(luna, banks).
uncle(oliver,banks).
aunt(sophia,banks).

grandchild(elio,benjamin).
grandson(tom,benjamin).
granddaughter(camila,emma).
greatgrandparent(tom,liam).
ancestor(lia,harper).
************************/
   
