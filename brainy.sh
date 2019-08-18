#!/bin/zsh

topics=("Age"  "Alone"  "Amazing"  "Anger"  "Anniversary"  "Architecture"  "Art"  "Attitude"  "Beauty"  "Best"  "Birthday"  "Brainy"  "Business"  "Car"  "Chance"  "Change"  "Christmas"  "Communication"  "Computers"  "Cool"  "Courage"  "Dad"  "Dating"  "Death"  "Design"  "Diet"  "Dreams"  "Easter"  "Education"  "Environmental"  "Equality"  "Experience"  "Experience"  "Failure"  "Faith"  "Family"  "Famous"  "Father's"  "Day"  "Fear"  "Finance"  "Fitness"  "Food"  "Forgiveness"  "Freedom"  "Friendship"  "Funny"  "Future"  "Gardening"  "God"  "Good"  "Government"  "Graduation"  "Great"  "Happiness"  "Health"  "History"  "Home"  "Hope"  "Humor"  "Imagination"  "Independence"  "Inspirational"  "Intelligence"  "Jealousy"  "Jealousy"  "Knowledge"  "Leadership"  "Learning"  "Legal"  "Life"  "Love"  "Marriage"  "Medical"  "Memorial"  "Day"  "Men"  "Mom"  "Money"  "Morning"  "Mother's"  "Day"  "Motivational"  "Movies"  "Moving"  "On"  "Music"  "Nature"  "New"  "Year's"  "Parenting"  "Patience"  "Patriotism"  "Peace"  "Pet"  "Poetry"  "Politics"  "Positive"  "Power"  "Relationship"  "Religion"  "Religion"  "Respect"  "Romantic"  "Sad"  "Saint"  "Patrick's"  "Day"  "Science"  "Smile"  "Society"  "Space"  "Sports"  "Strength"  "Success"  "Sympathy"  "Teacher"  "Technology"  "Teen"  "Thankful"  "Thanksgiving"  "Time"  "Travel"  "Trust"  "Truth"  "Valentine's"  "Day"  "Veterans"  "Day"  "War"  "Wedding"  "Wisdom"  "Women"  "Work")

topic=$(echo "${topics[$RANDOM%${#topics[@]}]}" | sed "s/ //g" | sed "s/'//g" | tr '[:upper:]' '[:lower:]')
quoted=''
while [ -z "$quoted" ]
do
    quoted=$(curl -s "https://www.brainyquote.com/topics/$topic")
done

quoted=$(echo "$quoted" | grep -o 'view quote">.*</' | sed 's/view quote">//' | sed "s/&#39;/'/g" | sed 's/<\///')

quotes=("${(f)quoted}")
quote="${quotes[ $RANDOM % ${#quotes[@]} ]}"

#if [ "$(id -u)" -eq 0 ]
#then
#    defaults write /Library/Preferences/com.apple.loginwindow.plist LoginwindowText "$quote"
#    echo "$quote" > /etc/brainy
#else
    echo "$quote" | fold -w $(tput cols) -s
#fi
