#!/bin/fish

set length ( math ( awk '{ l=length($0);if(m<l) m=l } END{ print m }' ~/todolist.txt ) + 3 )

set minLength 50
if test $length -lt $minLength
   set length $minLength
end

set width  ( math $length + ( math 2 - $length%2 ) )

function echoLine
   for i in ( seq $width )
      echo -n "="
   end
   echo
end

function echoHalfLine
   for i in ( seq ( math ( math $width - 12 ) / 2 ) )
      echo -n "="
   end
end

echo
echoLine
echoHalfLine
echo -n "  My  TODO  "
echoHalfLine
echo
echoLine
awk 'BEGIN{ print "" };{ print "  " $0 };END{ print "" }' ~/todolist.txt
echoLine
echo
