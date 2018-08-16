#!/bin/sh


add_user(){
	count_lines=`sudo cat /root/agenda.txt | wc -l`
	id_user=$((count_lines + 1))
	#old_IFS="$IFS"
	IFS=:
	echo "Please input contact data separted by colons ..."
	read name phone email
	while  echo "${email}" | grep -v '^[a-zA-Z0-9]*@[a-zA-Z0-9]*\.[a-zA-Z0-9]*$' >/dev/null
	do
		echo "It isn\'t a email, please correct it"
		read email
	done
	while echo "${phone}" | grep -v '[[:digit:]]\{2\}[ -]\?[[:digit:]]\{10\}' >/dev/null
	do
		 echo "It isn\'t a phone, please correct it"
                read phone

	done	
	#IFS=$old_IFS
	echo "name is: $name, phone is: $phone, email is: $email"
	echo "$id_user  $name  $phone      $email" >> agenda.txt
}

edit_user(){
	echo "Please input complete name of user"
	read username
	rtgrep=`sudo grep -i "$username" agenda.txt`
	echo "$rtgrep"
	add_user
	sudo sed -i "/$username/d" ./agenda.txt
	echo "Fine! Your user information had been updated"
	display_users
}

remove_user(){
	echo "Please input complete name of user"
	read username
	rtgrep=`sudo grep -i "$username" agenda.txt`
	echo "$rtgrep"
	sudo sed -i "/$username/d" ./agenda.txt
	echo "One User deleted"
	display_users
}

display_users(){
	flcont=`sudo cat agenda.txt`
	echo "$flcont"
}

display_menu(){
	echo "What do you want to do?, Please Select one Option"
	echo "Input 1 for adding user data"
	echo "Input 2 for editting user data"
	echo "Input 3 for removing user data"
	echo "Input 4 for displaying addressbook"
	echo "Input 5 for Leave addressbook"
	read option
	case $option in 
		1)
			add_user 
			display_menu
			;;
		2)
			edit_user  
			display_menu
			;;
		3)
			remove_user 
			display_menu
			;;
		4)
			display_users
			display_menu 
			;;
		5) 
			echo "Bye"
			break ;;

		*)
			echo "Invalid Option"
			display_menu
			;;
	esac
}


echo "ADDRESS BOOK \n"
display_menu



