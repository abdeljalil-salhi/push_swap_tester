#/bin/sh
#42login: absalhi

RESET='\033[0m'; ITALIC='\033[3m'
RED='\033[0;31m'; GREEN='\033[0;32m'; BLUE='\033[0;36m'

let less_003=0; let more_003=0; let inst_003=0; cases_003=()
let less_005=0; let more_005=0; let inst_005=0; cases_005=()
let less_100=0; let more_100=0; let inst_100=0; cases_100=()
let less_500=0; let more_500=0; let inst_500=0; cases_500=()

START=-10000; END=10000; FILE=./push_swap
if [[ -f "$FILE" ]];
then printf "${GREEN}${FILE}: testing...${RESET}\n\n"
elif [[ -f "./Makefile" ]];
then make; printf "\n"
else printf "${RED}${FILE}: file not found.\n${RESET}"; exit 1; fi

printf "${BLUE} Testing 3 random numbers (from ${START} to ${END}) x10:${RESET}\n"
for i in $(seq -f "%03g" 1 10)
	do
		ARG=`ruby -e "puts (${START}..${END}).to_a.shuffle.take(3).join(' ')"`; inst_003=`./push_swap $ARG | wc -l`
		printf " $i\t$inst_003\r"
		if [[ $inst_003 -gt 3 ]]
		then more_003=`expr $more_003 + 1`; cases_003+=($inst_003); printf "$ARG\n" >> ranges_3.txt
		else less_003=`expr $less_003 + 1`; fi
	done

printf "\n${BLUE} Testing 5 random numbers (from ${START} to ${END}) x10:${RESET}\n"
for i in $(seq -f "%03g" 1 10)
	do
		ARG=`ruby -e "puts (${START}..${END}).to_a.shuffle.take(5).join(' ')"`; inst_005=`./push_swap $ARG | wc -l`
		printf " $i\t$inst_005\r"
		if [[ $inst_005 -gt 12 ]]
		then more_005=`expr $more_005 + 1`; cases_005+=($inst_005); printf "$ARG\n" >> ranges_5.txt
		else less_005=`expr $less_005 + 1`; fi
	done

printf "\n${BLUE} Testing 100 random numbers (from ${START} to ${END}) x50:${RESET}\n"
for i in $(seq -f "%03g" 1 50)
	do
		ARG=`ruby -e "puts (${START}..${END}).to_a.shuffle.take(100).join(' ')"`; inst_100=`./push_swap $ARG | wc -l`
		printf " $i\t$inst_100\r"
		if [[ $inst_100 -gt 700 ]]
		then more_100=`expr $more_100 + 1`; cases_100+=($inst_100); printf "$ARG\n" >> ranges_100.txt
		else less_100=`expr $less_100 + 1`; fi
	done

printf "\n${BLUE} Testing 500 random numbers (from ${START} to ${END}) x100:${RESET}\n"
for i in $(seq -f "%03g" 1 100)
	do
		ARG=`ruby -e "puts (${START}..${END}).to_a.shuffle.take(500).join(' ')"`; inst_500=`./push_swap $ARG | wc -l`
		printf " $i\t$inst_500\r"
		if [[ $inst_500 -gt 5500 ]]
		then more_500=`expr $more_500 + 1`; cases_500+=($inst_500); printf "$ARG\n" >> ranges_500.txt
		else less_500=`expr $less_500 + 1`; fi
	done

printf "\n\n${BLUE} 3 random numbers:${RESET}\t\t"
if [[ $less_003 -gt $more_003 ]]
then printf "${GREEN}[OK]${RESET}\n"
else printf "${RED}[KO]${RESET}\n"; fi
printf "${ITALIC} Less than 3 instructions:${RESET}\t$less_003\n"
printf "${ITALIC} More than 3 instructions:${RESET}\t$more_003"
if [[ $more_003 -gt 0 ]]
then
	printf "${ITALIC} ==> "
	for _case in "${cases_003[@]}"
		do
			printf "$_case "
		done
	printf "${RESET}\n"
else printf "\n"; fi

printf "\n${BLUE} 5 random numbers:${RESET}\t\t"
if [[ $less_005 -gt $more_005 ]]
then printf "${GREEN}[OK]${RESET}\n"
else printf "${RED}[KO]${RESET}\n"; fi
printf "${ITALIC} Less than 12 instructions:${RESET}\t$less_005\n"
printf "${ITALIC} More than 12 instructions:${RESET}\t$more_005"
if [[ $more_005 -gt 0 ]]
then
	printf "${ITALIC} ==> "
	for _case in "${cases_005[@]}"
		do
			printf "$_case "
		done
	printf "${RESET}\n"
else printf "\n"; fi

printf "\n${BLUE} 100 random numbers:${RESET}\t\t"
if [[ $less_100 -gt $more_100 ]]
then printf "${GREEN}[OK]${RESET}\n"
else printf "${RED}[KO]${RESET}\n"; fi
printf "${ITALIC} Less than 700 instructions:${RESET}\t$less_100\n"
printf "${ITALIC} More than 700 instructions:${RESET}\t$more_100"
if [[ $more_100 -gt 0 ]]
then
	printf "${ITALIC} ==> "
	for _case in "${cases_100[@]}"; do printf "$_case "; done
	printf "${RESET}\n"
else printf "\n"; fi

printf "\n${BLUE} 500 random numbers:${RESET}\t\t"
if [[ $less_500 -gt $more_500 ]]
then printf "${GREEN}[OK]${RESET}\n"
else printf "${RED}[KO]${RESET}\n"; fi
printf "${ITALIC} Less than 5500 instructions:${RESET}\t$less_500\n"
printf "${ITALIC} More than 5500 instructions:${RESET}\t$more_500"
if [[ $more_500 -gt 0 ]]
then
	printf "${ITALIC} ==> "
	for _case in "${cases_500[@]}"
		do
			printf "$_case "
		done
	printf "${RESET}\n"
else printf "\n"; fi
