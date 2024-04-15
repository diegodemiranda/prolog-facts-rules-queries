%Questão 1
%a)
% Predicado progenitor(X, Y): X é progenitor de Y
progenitor(jose, joao).
progenitor(jose, ana).
progenitor(jose, jessica).
progenitor(jose, lucas).
progenitor(maria, joao).
progenitor(maria, ana).
progenitor(maria, jessica).
progenitor(maria, lucas).
progenitor(joao, mario).
progenitor(helena, carlos).
progenitor(ana, helena).
progenitor(ana, joana).
progenitor(joana, antonio).
progenitor(joana, juares).
progenitor(jessica, heloisa).
progenitor(lucas, fagundes).
progenitor(lucas, marcia).
progenitor(lucas, julio).
progenitor(marcia, luciano).
progenitor(rodrigo, luciano).

%b)
% Predicado sexo(X, S): X tem o sexo S (masculino ou feminino)
sexo(jose, masculino).
sexo(maria, feminino).
sexo(joao, masculino).
sexo(ana, feminino).
sexo(jessica, feminino).
sexo(lucas, masculino).
sexo(mario, masculino).
sexo(helena, feminino).
sexo(joana, feminino).
sexo(antonio, masculino).
sexo(juares, masculino).
sexo(heloisa, feminino).
sexo(fagundes, masculino).
sexo(marcia, feminino).
sexo(julio, masculino).
sexo(luciano, masculino).
sexo(rodrigo, masculino).
sexo(carlos, masculino).

% Predicado irmão(X, Y): X é irmão de Y
irmao(X, Y) :- 
    progenitor(P, X), progenitor(P, Y), X \= Y, sexo(X, masculino).
% Predicado irmã(X, Y): X é irmã de Y
irma(X, Y) :- 
    progenitor(P, X), progenitor(P, Y), X \= Y, sexo(X, feminino).
% Predicado descendente(X, Y): X é descendente de Y
descendente(X, Y) :- 
    progenitor(Y, X).
descendente(X, Y) :- 
    progenitor(Y, Z), descendente(X, Z).
% Predicado mãe(X, Y): X é mãe de Y
mae(X, Y) :- 
    progenitor(X, Y), sexo(X, feminino).
% Predicado pai(X, Y): X é pai de Y
pai(X, Y) :- 
    progenitor(X, Y), sexo(X, masculino).

% Predicado avô(X, Y): X é avô de Y
avo(X, Y) :- 
    progenitor(X, Z), progenitor(Z, Y), sexo(X, masculino).

% Predicado tio(X, Y): X é tio de Y
tio(X, Y) :- 
    irmao(X, Z), progenitor(Z, Y), sexo(X, masculino).

% Predicado primo(X, Y): X é primo de Y
primo(X, Y) :- 
    progenitor(P1, X), progenitor(P2, Y), irmao(P1, P2).

% Perguntas
% 1. O João é filho do José?
joao_e_filho_de_jose :- 
    progenitor(jose, joao).

% 2. Quem são os filhos da Maria?
filhos_de_maria(X) :- 
    progenitor(maria, X).

% 3. Quem são os primos do Mário?
primos_do_mario(X) :- 
    primo(X, mario).

% 4. Quantos sobrinhos/sobrinhas com um tio existem na família Pinheiro?
numero_de_sobrinhos(T, N1, N2) :-
    findall(S, (tio(T, S), sexo(S, masculino)), LM), 
    findall(S, (tio(T, S), sexo(S, feminino)), LF), 
    length(LM, N1), 
    length(LF, N2).

% 5. Quem são os ascendentes do Carlos?
ascendente(X, Y) :- 
    progenitor(X, Y).
ascendente(X, Y) :- 
    progenitor(X, Z), ascendente(Z, Y).
ascendentes_do_carlos(X) :- 
    ascendente(X, carlos).

% 6. A Helena tem irmãos? E irmãs?
helena_tem_irmaos(X) :- 
    irmao(X, helena), sexo(X, masculino), X \= helena.
helena_tem_irmas(X) :- 
    irma(X, helena), sexo(X, feminino), X \= helena.

% 7. Quem é avô/avó de Luciano?
avo_de_luciano(X, luciano) :-
    progenitor(X, Z),
    progenitor(Z, luciano),
    sexo(X, masculino).

avó_de_luciano(X, luciano) :-
    progenitor(X, Z),
    progenitor(Z, luciano),
    sexo(X, feminino).

% 8. Quem tem netos na família Pinheiro?
netos_na_familia(X) :- progenitor(X, Y), descendente(Y, _).