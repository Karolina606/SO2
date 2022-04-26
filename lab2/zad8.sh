#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 2
#
# Celem zajęć jest nabranie doświadczenia w podstawowej pracy z powłoką Bash,
# w szczególności w nawigowaniu po drzewie katalogów i sprawdzaniu uprawnień.
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
# Zadanie 8.
# Wyszukać w katalogu `dane/` i jego bezpośrednich podkatalogach (jeden poziom
# wgłąb) wszystkie pliki zwyczajne (nie katalogi!), które są w systemie plików
# oznaczone jako wykonywalne. Wyświetlić ścieżki do wszystkich znalezionych
# plików względem katalogu `dane/`. Każdą ścieżkę wyświetlić w osobnej linii.
#

to_remove='./dane/'
IFS=''

######################### WERSJA 1 #########################
for file in `find ./dane/ -maxdepth 2 -type f -perm /a+x`; do
    # echo $file | cut -c 8-
    printf '%s\n' "${file//$to_remove/}"
done

######################### WERSJA 2 #########################
# find ./dane/ -maxdepth 2 -type f -perm /a+x -exec sh -c "echo {} | cut -c 8- " \;
