filter([H|_], [H|_]).
filter(_, _) :- fail.

edge(a,b) :- !.
edge(a,c) :- !.
edge(a,d) :- !.
edge(b,c) :- !.
edge(b,d) :- !.
edge(c,d) :- !.

edge(1,2) :- !.
edge(2,3) :- !.
edge(3,4) :- !.
edge(4,5) :- !.
edge(5,1) :- !.
edge(1,6) :- !.
edge(2,6) :- !.
edge(3,6) :- !.
edge(5,6) :- !.
edge(3,5) :- !.

check_edge([]) :- !.
check_edge([_]) :- !.
check_edge([X,Y|T]) :-
    %(edge(X,Y); edge(Y,X)),
    !,
    (edge(X,Y); edge(Y,X)),
    !,
    check_edge([Y|T]).
%check_edge([X,Y|T]) :-
%    edge(X,Y) -> (
%        check_edge([Y|T])
%    ) ; (
%        edge(Y,X) -> check_edge([Y|T]) ; fail
%    ).

wrap([H|List], Result) :-
    append([H|List], [H], Result).

print_permutations(List) :-
    permutation(List, Perm),
    filter(List, Perm),
    wrap(Perm, Wrapped),
    check_edge(Wrapped),
    write(Wrapped), nl,
    fail.
print_permutations(_).