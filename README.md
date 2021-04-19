# 3Points-Language
This project is a series of programs written in ruby, prolog, and scheme, which work together to define a 3Point language.

This language works with the following grammar

ID = point(NUM, NUM); ID = point(NUM, NUM); ID = point(NUM, NUM).
where ID = LETTER+, and NUM = DIGIT+

This grammer is written into a test file, and then the ruby parser is called on this text file along with a flag of either -s, or -p. The flag will determine what output the parser will create should the grammer in the passed in file be correct both lexically and syntactically. A -s flag will set the parser to output a code segment that can then be passed into the scheme program. This code segment will call a function to determine the traingular specifications of these three points, (ie. if the points make a triangle, what length the sides are, the perimiter and area of the triangle, and the angles in the triangle). A -p flag will set the parser to output a series of queries that can be called from the prolog program. These code segments will ask questions of the kind of triangle that is made up by the three points, if they make a triangle at all.

## How to integrate between the ruby parser and the scheme program:
* Create a text file containing your program written in the described grammer and name it something like 'myprogram.cpl'
* Then run the parser with the following command: 'ruby parser.rb myprogram.cpl -s > myprogram.scm'
* Append this output to the scheme program with the following command: 'cat threepoints.scm myprogram.scm > full.scm'
* Run this new full.scm program with the command: 'scheme --load full.scm'

## How to integrate between the ruby parser and the prolog program:\n
* Create a text file containing your program written in the described grammer and name it something like 'myprogram.cpl'
* Then run the parser with the following command: 'ruby parser.rb myprogram.cpl -p > myprogram.pl'
* Append this output to the prolog program with the following command: 'cat threepoints.pl myprogram.pl > full.pl'
* Run this new full.scm program with the command: 'swipl -1 -f full.pl -t main'
