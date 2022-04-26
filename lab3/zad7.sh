#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 3
#
# Celem zajęć jest pogłębienie wiedzy na temat struktury systemu plików,
# poruszania się po katalogach i kontroli uprawnień w skryptach powłoki.
# Proszę unikać wykorzystywania narzędzia `find` w ramach bieżących zajęć.
#
# Nie przywiązujemy wagi do środowiska roboczego – zakładamy, że jego pliki,
# inne niż te podane wprost w treści zadań, mogą ulec zmianie, a przygotowane
# rozwiązania nadal powinny działać poprawnie (robić to, o czym zadanie mówi).
#
# Wszystkie chwyty dozwolone, ale ostatecznie w wyniku ma powstać tylko to,
# o czym mowa w treści zadania – tworzone samodzielnie ewentualne tymczasowe
# pliki pomocnicze należy usunąć.
#

#
# Zadanie 7.
# Plik `links.txt` z katalogu `dane/` zawiera listę ścieżek. Proszę określić
# które z tych ścieżek to dowiązania do istniejących plików wykonywalnych.
# Jako wynik wyświetlić pasujące wpisy z pliku (ścieżki do dowiązań).
#

IFS=$'\n';
while read -r line 
do
    if [ -L "${line}" -a -e "${line}" ]; then 
        pointed_path=`readlink -f ${line}`;
        if [ ! "${pointed_path}" = "" ]; then
            if [ -x $pointed_path ]; then
                echo "${line}";
                # echo `ls -l "${pointed_path}" `
            fi
        # readlink -f ${line};
        fi
    fi
done < dane/links.txt