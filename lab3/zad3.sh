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
# Zadanie 3.
# Odnaleźć w katalogu `dane/pierwiastki/` wszystkie wiszące dowiązania miękkie
# – to jest takie, które wskazują na elementy nieistniejące w systemie plików.
# Wyświetlić nazwy plików ze znalezionymi dowiązaniami, każdą w osobnej linii.
# Nie wyświetlać nic ponadto!
#

######################### WERSJA 1 #########################
IFS=$'\n'

cd dane/pierwiastki/; 
for file in `find . -type l`; do
    pointed_path=$(readlink ${file});
    
    if [ ! -f "${pointed_path}" ]; then
        echo `basename "${file}"`;
    fi
done
cd ../.. ;


######################### WERSJA 2 #########################
#### Problem z Silicone - Too many levels of symlinks ######
# find dane/pierwiastki/ -xtype l -exec echo `basename {}` \;


######################### WERSJA 3 #########################
#### Problem z Silicone - Too many levels of symlinks ######
# find -L dane/pierwiastki/ -type l -exec ls {} \;


######################### WERSJA 4 #########################
#### Problem z Silicone - Too many levels of symlinks ######
# IFS=$'\n'
# for file in `find -L dane/pierwiastki/ -type l`; do
#     # echo "${file}";
#     # if_file_exists=$([ ! -f `realpath ${file}` ])
#     # if [ ! -e "$file" ]; then
#         echo `basename "${file}"`;
#     # fi
# done