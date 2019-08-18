#!/bin/zsh

! [[ $(<<< $@ | grep '\-\-debug') ]] && DEBUG=false || DEBUG=true

while getopts ':N:' opt
do
    case $opt in
    'N')    [[ $OPTARG > 0 ]] && MAX_QUOTES=$OPTARG
            ;;
    esac
done

tags=('Love' 'Life' 'Inspirational' 'Humor' 'Philosophy' 'God' 'Inspirational ' 'Truth' 'Wisdom' 'Romance' 'Poetry' 'Death' 'Happiness' 'Hope' 'Faith' 'Inspiration' 'Writing' 'Religion' 'Success' 'Relationships' 'Life-lessons' 'Motivational' 'Knowledge' 'Time' 'Love' 'Spirituality' 'Science' 'Education' 'Books')

while [ -z $quote ]
do
    tag=$(<<< $tags[(($RANDOM % $#tags + 1))] | tr '[:upper:]' '[:lower:]')
    page=$(( $RANDOM % 100 + 1 ))

    while [ -z $quoted ]
    do
        quoted=$(curl -s "https://www.goodreads.com/quotes/tag/$tag?page=$page")
    done

    if ($DEBUG); then <<< $quoted > ~/Desktop/quoted.log; fi

    quoted=$(<<< "$quoted" | grep 'quoteText">' -A 5 | tr '\n' ' ' | sed 's/  //g' )
    quoted=("${(@s/ -- /)quoted}")

    if ! ($DEBUG)
    then
        quoted=$quoted[(( $RANDOM % $#quoted + 1 ))]
        quote=$(<<< $quoted | grep -o '&ldquo;.*&rdquo;' | sed 's/\<br \/>//g' | sed 's/<i>//g' | sed 's/<\/i>//g' | sed 's/(\.\.\.)//g' | sed 's/\[//g' | sed 's/\]//g' | sed 's/  / /g')

        #if [ $(<<< $quote | grep -o '"' | wc -l) -eq 0 ]; then
            quote=$(<<< $quote | sed 's/&ldquo;//g' | sed 's/&rdquo;//g' | sed 's/"/\\"/g')
        #else
         #   quote=$(<<< $quote | sed 's/&ldquo;/"/' | sed 's/&rdquo;/"/')
        #fi

        if (( $(<<< $quote | wc -m) > 350 ))
        then
            quoted=
            quote=
        else
            author=$(<<< $quoted | grep -o '<span.*</span>' | grep -o '>.*<' | sed 's/> //' | sed 's/ <//' | sed 's/>//' | sed 's/<//' | sed 's/,//')
        fi
    else        
        [ -z $MAX_QUOTES ] && MAX_QUOTES=$#quoted

        echo "{"
        for i in {1..$MAX_QUOTES}
        do
            q=$quoted[i]
            quote=$(<<< $q | grep -o '&ldquo;.*&rdquo;' | sed 's/<br \/>//g' | sed 's/<i>//g' | sed 's/<\/i>//g' | sed 's/(\.\.\.)//g' | sed 's/\[//g' | sed 's/\]//g' | sed 's/  / /g')
            if [ $(<<< $quote | grep -o '"' | wc -l) -eq 0 ]
            then
                quote=$(<<< $quote | sed 's/&ldquo;//g' | sed 's/&rdquo;//g' | sed 's/"/\\"/g' )
            else
                quote=$(<<< $quote | sed 's/&ldquo;/"/' | sed 's/&rdquo;/"/' | sed 's/"/\\"/g' )
            fi
            #author=$(<<< $q | grep -o '<span.*</span>' | grep -o '>.*<' | sed 's/> //' | sed 's/ <//' | sed 's/>//' | sed 's/<//' | sed 's/,//')
            echo -n "\t\"$i\":\"$quote\"" && ! [[ $q == $quoted[$MAX_QUOTES] ]] && echo "," 
        done
        echo -e "\n}"

        exit
    fi
done

if ! [[ $- == *i* ]] && ! [[ -o login ]]
then
    echo $quote
else
    echo $quote | fold -w $(tput cols) -s
fi

if [ "$(id -u)" -eq 0 ]
then
    defaults write /Library/Preferences/com.apple.loginwindow.plist LoginwindowText "$quote"
    print "$quote – $author" > /etc/qotd
fi
