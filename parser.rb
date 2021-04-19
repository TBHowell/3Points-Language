#Trent Howell
#parser.rb

#grabs our user input from the command call and initializes the variables we will be using
fileName = ARGV[0]
outputType = ARGV[1]
tokens = []
propergrammar = ["ID","EQUAL","POINT","LPAREN","NUM","COMMA","NUM","RPAREN","SEMICOLON","ID","EQUAL","POINT","LPAREN","NUM","COMMA","NUM","RPAREN","SEMICOLON","ID","EQUAL","POINT","LPAREN","NUM","COMMA","NUM","RPAREN","PERIOD"]
i = 0
temp = ""
temp2 = ""
nums = []
i2 = 0
hasDec = false

#opens the file and generates the initial comment
if (outputType == "-s")
  print "; processing input file " + fileName + "\n"
elsif (outputType == "-p")
  print "/* processing input file " + fileName + "\n"
end
toParse = File.open(fileName)

#reads file input and lexically analyzes character by character until the end of the file
while c = toParse.getc
  if c != ' ' && c != "\n"
    wt = false
    if c == '='
      temp2 = "EQUAL"
      wt = true
    elsif c == '('
      temp2 = "LPAREN"
      wt = true
    elsif c == ')'
      temp2 = "RPAREN"
      wt = true
    elsif c == ','
      temp2 = "COMMA"
      wt = true
    elsif c == '.' && (!hasDec && !(temp =~ /[0-9]/))
      temp2 = "PERIOD"
      wt = true
    elsif c == ';'
      temp2 = "SEMICOLON"
      wt = true
    else
      temp += c
      if c == '.'
        hasDec = true
      end
    end

    if wt
      if (temp =~ /[a-zA-Z]/) && !(temp =~ /[-!$@#$%^&*_+|~`{}\[\]:"'<>?\/]/) && !(temp =~ /[0-9]/)
        if temp == "point"
          tokens[i] = "POINT"
          i += 1
        else
          tokens[i] = "ID " + temp.strip
          i += 1
        end

        elsif (temp =~ /[0-9]/) && !(temp =~ /[-!$@#$%^&*_+|~`{}\[\]:"'<>?\/]/)
          tokens[i] = "NUM " + temp.strip
          nums[i2] = temp.strip
          i += 1
          i2 += 1
          hasDec = false

        elsif temp != ""
          puts "Lexical Error!"
          abort
        end

        tokens[i] = temp2
        temp = ""
        i += 1
    end
  end
end
i = 0
i2 = 0

#checks the tokens generated from the lexical analyzer and trys them against the propergramar
while i < tokens.length-1
  if !(tokens[i].include? propergrammar[i])
    puts "Synax Error!"
    abort
  end
  i += 1
end

#generates final comment and code for either prologue or scheme depending on the users input tag
if (outputType == "-s")
  puts "; Lexical and Syntax analysis passed" + "\n"
  puts "(calculate-triangle (make-point " + nums[i2] + " " + nums[i2+1] + ") (make-point " + nums[i2+2] + " " + nums[i2+3] + ") (make-point " + nums[i2+4] + " " + nums[i2+5] + "))\n"
elsif (outputType == "-p")
  num1 = nums[i2]
  num2 = nums[i2+1]
  num3 = nums[i2+2]
  num4 = nums[i2+3]
  num5 = nums[i2+4]
  num6 = nums[i2+5]
  puts "  Lexical and Syntax analysis passed */" + "\n"
  puts "query(line(point2d(" + num1 +","+ num2 +"), point2d(" + num3 +","+ num4 +"), point2d(" + num5 +","+ num6 +")))" + "\n"
  puts "query(triangle(point2d(" + num1 +","+ num2 +"), point2d(" + num3 +","+ num4 +"), point2d(" + num5 +","+ num6 +")))" + "\n"
  puts "query(vertical(point2d(" + num1 +","+ num2 +"), point2d(" + num3 +","+ num4 +"), point2d(" + num5 +","+ num6 +")))" + "\n"
  puts "query(horizontal(point2d(" + num1 +","+ num2 +"), point2d(" + num3 +","+ num4 +"), point2d(" + num5 +","+ num6 +")))" + "\n"
  puts "query(equilateral(point2d(" + num1 +","+ num2 +"), point2d(" + num3 +","+ num4 +"), point2d(" + num5 +","+ num6 +")))" + "\n"
  puts "query(isosceles(point2d(" + num1 +","+ num2 +"), point2d(" + num3 +","+ num4 +"), point2d(" + num5 +","+ num6 +")))" + "\n"
  puts "query(right(point2d(" + num1 +","+ num2 +"), point2d(" + num3 +","+ num4 +"), point2d(" + num5 +","+ num6 +")))" + "\n"
  puts "query(scalene(point2d(" + num1 +","+ num2 +"), point2d(" + num3 +","+ num4 +"), point2d(" + num5 +","+ num6 +")))" + "\n"
  puts "query(acute(point2d(" + num1 +","+ num2 +"), point2d(" + num3 +","+ num4 +"), point2d(" + num5 +","+ num6 +")))" + "\n"
  puts "query(obtuse(point2d(" + num1 +","+ num2 +"), point2d(" + num3 +","+ num4 +"), point2d(" + num5 +","+ num6 +")))" + "\n"
  puts "writeln(T) :- write(T), nl." + "\n"
  puts "main:- forall(query(Q), Q-> (writeln(‘yes’)) ; (writeln(‘no’)))," + "\n"
  puts "      halt." + "\n"
end

#closes the file and ends the program
toParse.close
