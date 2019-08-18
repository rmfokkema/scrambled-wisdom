#!/bin/zsh
tags=( 'love'  'life'  'inspirational'  'humor'  'philosophy'  'god'  'inspirational '  'truth'  'wisdom'  'romance'  'poetry'  'death'  'happiness'  'hope'  'faith'  'inspiration'  'writing'  'religion'  'success'  'relationships'  'life-lessons'  'motivational'  'knowledge'  'time'  'love'  'spirituality'  'science'  'education'  'books'  )

while [ -z $quote ]
do
    tag=$tags[( RANDOM % $#tags + 1)]
    page=$(( RANDOM % 100 + 1 ))

    while [ -z $quoted ]
    do
        quoted=$(curl -s "https://www.goodreads.com/quotes/tag/$tag?page=$page")
        sleep 1
    done

    quoted=$(<<< "$quoted" | grep 'quoteText">' -A 5 | tr '\n' ' ' | sed 's/  //g' )
    quoted=("${(@s/ -- /)quoted}")

        quoted=$quoted[( RANDOM % $#quoted + 1 )]
        [ $(wc -m <<< $quoted) -gt 350 ] && {
        	unset quoted
        	unset quote
        	continue
        }
        quote=$(<<< $quoted | grep -o '&ldquo;.*&rdquo;' \
        					| sed 's/\<br \/>//g' 	| sed 's/<i>//g' 		| sed 's/<\/i>//g' \
        					| sed 's/(\.\.\.)//g' 	| sed 's/\[//g' 		| sed 's/\]//g' \
        					| sed 's/  / /g' 		| sed 's/&ldquo;//g'	| sed 's/&rdquo;//g' \
        					| sed 's/"//g')
		
done        					

#            author=$(<<< $quoted | grep -o '<span.*</span>' | grep -o '>.*<' | sed 's/> //' | sed 's/ <//' | sed 's/>//' | sed 's/<//' | sed 's/,//')
        
echo $quote
