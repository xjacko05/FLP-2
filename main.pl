% Hamiltonian cycle
% FLP LOG 2022/2023
% Autor: Martin Jacko (222092) <xjacko05@stud.fit.vutbr.cz>
% Contents: prolog code

%stating which facts will be dynamic
:- dynamic cycle/1.
:- dynamic edge/2.
:- dynamic vertex/1.

main :-
    prompt(_, ''),
	read_lines(Input),
    process_input(Input),
    findall(X, vertex(X), Vertices),
    print_cycles(Vertices).

%fill knowledge base with edges and vertices based on input, ignores lines with different format
process_input([]).
process_input([[From,' ',To]|T]) :-
    valid_vertex_name(From),
    valid_vertex_name(To),
    %vertex is added only if it was not added before
    (((\+ vertex(From)), assertz((vertex(From)))) ; true),
    (((\+ vertex(To)), assertz((vertex(To)))) ; true),
    assertz((edge(From, To) :- !)),
    process_input(T).
process_input([_|T]) :-
    process_input(T).

%checks if vertex name is valid (if it is capital letter of english aplhabet)
valid_vertex_name(Vertex) :-
  member(Vertex, ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']).

%filters duplicate paths, which are essentially same, but with different offset
filter([H|_], [H|_]).
filter(_, _) :- fail.

%checks if given path exists according to graph description
check_path([]) :- !.
check_path([_]) :- !.
check_path([X,Y|T]) :-
    !,
    (edge(X,Y); edge(Y,X)),
    !,
    check_path([Y|T]).

%will transform given path to cycle by appending first element of list to ist end
wrap([H|T], Result) :-
    append([H|T], [H], Result).

%takes list, which represents cycle and prints it according to specification
custom_print([]) :- !.
custom_print([_]) :- !.
custom_print([X,Y|T]) :-
    write(X),
    write('-'),
    write(Y),
    write(' '),
    custom_print([Y|T]).

%generates every possible cycle in a given graph
print_cycles(List) :-
    (\+ length(List, 1)),
    (\+ length(List, 2)),
    permutation(List, Path),
    filter(List, Path),
    wrap(Path, Cycle),
    check_path(Cycle),
    %checks if reverse of the current path was already processed, to avoid duplicates
    reverse(Cycle, Reversed),
    (\+ cycle(Reversed)),
    asserta((cycle(Cycle) :- !)),
    custom_print(Cycle), nl,
    fail.
print_cycles(_).

%IO handling, taken from https://moodle.vut.cz/pluginfile.php/573866/mod_resource/content/2/flp-cv4.pdf
read_line(L,C) :-
    get_char(C),
    (isEOFEOL(C), L = [], !;
    read_line(LL, _),
    [C|LL] = L ).

isEOFEOL(C) :-
    C == end_of_file;
    (char_code(C,Code), Code==10).

read_lines(Ls) :-
    read_line(L, C),
    (C == end_of_file, Ls=[] ;
    (read_lines(LLs), [L|LLs] = Ls)).
