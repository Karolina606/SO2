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
# Zadanie 5.
# Plik `dane/twardziel` stanowi dowiązanie twarde do pewnych plików z katalogu
# `dane/icao/`. Proszę odnaleźć które to pliki i wyświetlić ich nazwy, każdą
# w osobnej linii.
#

######################### WERSJA 1 #################################
# wykorzystanie flagi -ef, sprawdza czy to samo urządzenie i inode #
for file in `find dane/icao/ `; do
    if [ "${file}" -ef dane/twardziel ]; then
        echo `basename "${file}"`
    fi
done


######################### WERSJA 1 #################################
############### "ręczne" wciągnięcie numeru iwęzła  ################

# node_nr=$(ls -i dane/twardziel)
# IFS=$'\n'
# for file in `ls -i dane/icao/`; do
#     if [ "${file:0:8}" = "${node_nr:0:8}" ]; then
#         echo "${file:8}"
#     fi
# done