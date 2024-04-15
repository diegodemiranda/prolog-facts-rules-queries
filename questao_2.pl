%Questão 2:
% a) elemento(N,L,E): retorna o elemento E da posição N na lista L
%Se N é 0, o elemento é a cabeça da lista.
elemento(0,[X|_],X).
elemento(N,[_|T],E) :- 
% Caso contrário, decrementa-se N e recursivamente busca-se o elemento na cauda da lista.
    N > 0, N1 is N - 1, elemento(N1,T,E).

% b) apaga(X,L1,L2): apaga o elemento X da lista L1, resultando em L2
apaga(_, [], []).
% Se a cabeça da lista é X, apenas chama-se o predicado recursivamente para a cauda.
apaga(X, [X|T], L) :- 
    apaga(X, T, L).
% Se a cabeça da lista não é X, preserva-se a cabeça e continua-se a busca na cauda.
apaga(X, [H|T], [H|L]) :- 
    X \= H, apaga(X, T, L).

% c) insere(X,L1,L2): insere o elemento X no final da lista L1, resultando em L2
% Se a lista é vazia, L2 é [X].
insere(X, [], [X]).
insere(X, [H|T], [H|L]) :- 
    insere(X, T, L).

% d) concatena(L1, L2, L3): L3 é o resultado da junção das listas L1 e L2
% Se L1 é vazia, L3 é simplesmente L2.
concatena([], L, L).
% A concatenação da lista resultante é formada pela cabeça H seguida 
% pela concatenação da cauda T com a segunda lista L, resultando em L2.
concatena([H|T], L, [H|L2]) :- 
    concatena(T, L, L2).

% e) numeros_pares(L, Count): Count é a quantidade de números pares na lista L
numeros_pares([], 0).
% Se a cabeça da lista é par, incrementa-se Count e continua-se a busca na cauda.
numeros_pares([H|T], Count) :-
    Resto is H mod 2,
    Resto =:= 0,
    numeros_pares(T, RestoCount),
    Count is RestoCount + 1.
%Se a cabeça da lista não é par, simplesmente continua-se a busca na cauda.
numeros_pares([_|T], Count) :-
    numeros_pares(T, Count).

% f) minimo(L,X): X é o menor valor da lista L
min([X], X).
min([X|Y], M) :-
    min(Y, M1),
    X < M1,
    M is X.
min([X|Y], M) :-
    min(Y, M1),
    X >= M1,             
    M is M1.  

% g) media(X,L): X é o valor médio da lista L
soma([], 0).
soma([H|T], S) :- 
% Usa recursão para calcular a soma dos elementos da cauda T, armazenando o resultado em S1.
    soma(T, S1), S is S1 + H.

tamanho([], 0).
tamanho([_|T], N):-
    tamanho(T,N1),
% Incrementa N1 em 1 para contar a cabeça atual e armazena o resultado em N.
    N is N1+1.

media(X, L) :- 
    soma(L, S), tamanho(L, N), 
    X is S / N.

% h) ordenar(L, S): ordena a lista L em ordem decrescente em uma nova lista S
inserir(X, [], [X]).
inserir(X, [H|T], [X,H|T]) :- X =< H.
inserir(X, [H|T], [H|Resto]) :- X > H, inserir(X, T, Resto).

ordenar([], []).
% O predicado utiliza a recursão para ordenar a cauda da lista e, em seguida,
% insere a cabeça na lista ordenada resultante.
ordenar([H|T], ListaOrdenada) :-
    ordenar(T, TOrdenado),
    inserir(H, TOrdenado, ListaOrdenada).