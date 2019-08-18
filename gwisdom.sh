#!/bin/zsh

! [[ $(<<< $@ | grep '\-\-debug') ]] && DEBUG=false || DEBUG=true

delimiters=(',' '.' ':' ';' 'and' 'or' 'but')

quotes=()
for i in {1..7}
do
	quotes+="$(gready)"
	while :
	do
		d=$delimiters[(RANDOM % $#delimiters + 1)]
		grep $d <<< $quotes[i] > /dev/null
		[ $? -eq 1 ] && continue
		
		case $((RANDOM%4)) in
0)	[ ! -z "${quotes[i]##*$d}" ] && quotes[$i]="${quotes[i]##*$d}$d"
break
;;
1) [ ! -z "${quotes[i]#*$d}" ] && quotes[$i]="${quotes[i]#*$d}$d"
break
;;
2) [ ! -z "${quotes[i]%%$d*}" ] && quotes[$i]="${quotes[i]%%$d*}$d"
break
;;
3) [ ! -z "${quotes[i]%$d*}" ] && quotes[$i]="${quotes[i]%$d*}$d"
break
;;
esac
	done
	
	echo $quotes[i]
	parts=(${(s/./)quotes[$i]})
	[[ $#parts -gt 2 ]] && $quotes[i]=$parts[(RANDOM % $#parts + 1)] 
	echo -e "--> \t\t $quotes[i]"
	echo
done

echo $quotes[@]
exit
