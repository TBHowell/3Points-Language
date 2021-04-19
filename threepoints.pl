/* Trent Howell */
/* Threepoints.pl */
point2d(X,Y).

side(point2d(A,B),point2d(C,D),X):-
  X is sqrt(((A-C)**2)+((B-D)**2)).

check(point2d(A,B),point2d(C,D),point2d(E,F)):-
  side(point2d(A,B),point2d(C,D),X),
  side(point2d(A,B),point2d(E,F),Y),
  X=Y.

slope(point2d(A,B),point2d(C,D),X):-
  (not(A=C), not(B=D),
  X is (B-D)/(A-C));
  X is 0.

check2(point2d(A,B),point2d(C,D),point2d(E,F)):-
  slope(point2d(A,B),point2d(C,D),X),
  slope(point2d(A,B),point2d(E,F),Y),
  X=:=Y.

angle(point2d(A,B),point2d(C,D),point2d(E,F),X):-
  (vertical(point2d(A,B),point2d(C,D)),
  horizontal(point2d(A,B),point2d(E,F)),
  X is 90);
  (vertical(point2d(A,B),point2d(E,F)),
  horizontal(point2d(A,B),point2d(C,D)),
  X is 90);
  (slope(point2d(A,B),point2d(C,D),N),
  slope(point2d(C,D),point2d(E,F),M),
  X is atan(abs(M-N)/(1+M*N))*57.2958).

vertical(point2d(A,B),point2d(A,C)):-
  B<C;C<B.

horizontal(point2d(A,B),point2d(C,B)):-
  A<C;C<A.

line(point2d(A,B),point2d(C,D),point2d(E,F)):-
  (vertical(point2d(A,B),point2d(C,D)),vertical(point2d(A,B),point2d(E,F)),vertical(point2d(C,D),point2d(E,F)));
  (horizontal(point2d(A,B),point2d(C,D)),horizontal(point2d(A,B),point2d(E,F)),horizontal(point2d(C,D),point2d(E,F))).

triangle(point2d(A,B),point2d(C,D),point2d(E,F)):-
  not(line(point2d(A,B),point2d(C,D),point2d(E,F))),
  not((A=C,B=D);(A=E,B=F);(C=E,D=F)).

isosceles(point2d(A,B),point2d(C,D),point2d(E,F)):-
  triangle(point2d(A,B),point2d(C,D),point2d(E,F)),
  (check(point2d(A,B),point2d(C,D),point2d(E,F));
  check(point2d(C,D),point2d(A,B),point2d(E,F));
  check(point2d(E,F),point2d(A,B),point2d(C,D))).

equilateral(point2d(A,B),point2d(C,D),point2d(E,F)):-
  triangle(point2d(A,B),point2d(C,D),point2d(E,F)),
  check(point2d(A,B),point2d(C,D),point2d(E,F)),
  check(point2d(C,D),point2d(A,B),point2d(E,F)),
  check(point2d(E,F),point2d(A,B),point2d(C,D)).

right(point2d(A,B),point2d(C,D),point2d(E,F)):-
  triangle(point2d(A,B),point2d(C,D),point2d(E,F)),
  angle(point2d(A,B),point2d(C,D),point2d(E,F),X),
  angle(point2d(C,D),point2d(A,B),point2d(E,F),Y),
  angle(point2d(A,B),point2d(E,F),point2d(C,D),Z),
  ((X = 90; Y = 90; Z = 90);((X+Y>89,X+Y<91);(Y+Z>89,Y+Z<91))).

scalene(point2d(A,B),point2d(C,D),point2d(E,F)):-
  triangle(point2d(A,B),point2d(C,D),point2d(E,F)),
  not(isosceles(point2d(A,B), point2d(C,D), point2d(E,F))).

acute(point2d(A,B),point2d(C,D),point2d(E,F)):-
  triangle(point2d(A,B),point2d(C,D),point2d(E,F)),
  not(right(point2d(A,B),point2d(C,D),point2d(E,F))),
  angle(point2d(A,B),point2d(C,D),point2d(E,F),X),
  angle(point2d(C,D),point2d(A,B),point2d(E,F),Y),
  angle(point2d(A,B),point2d(E,F),point2d(C,D),Z),
  (X<90,Y<90,Z<90).

obtuse(point2d(A,B),point2d(C,D),point2d(E,F)):-
  triangle(point2d(A,B),point2d(C,D),point2d(E,F)),
  not(acute(point2d(A,B),point2d(C,D),point2d(E,F))).
