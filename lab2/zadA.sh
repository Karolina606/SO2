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
# Zadanie 10.
# W katalogu `dane/deep/` i wszystkich jego podkatalogach odnaleźć wszystkie
# pliki zwykłe, których nie możemy przeczytać ze względu na brak uprawnień
# dostępu. Zwrócić ścieżki do odnalezionych plików względem katalogu `dane/`.
# Opracowany skrypt powinien działać niezależnie od istniejącej liczby
# i poziomów podkatalogów.
#
# Wskazówka: pomocne może być zdefiniowanie funkcji i jej rekurencje wywołanie.
#

######################### WERSJA 1 #########################
################### BEZ UKRYTEGO FOLDERU ###################
# find ./dane/deep -not -path "*/.*" -type f ! -perm /a+r -exec sh -c "echo {} | cut -c 8-" \; 


######################### WERSJA 2 #########################
################### Z UKRYTYM FOLDEREM #####################
# find ./dane/deep -type f ! -perm /a+r -exec sh -c "echo {} | cut -c 8-" \; 

######################### WERSJA 3 #########################
find_files() {
    for element in `ls $1`; do
        # ustalanie pełniej ścieżki od katalogu ./dane
        element="$1/${element}";

        if [ -f "${element}" ]; then
            # jeśli obiekt istnieje i jest plikiem

            if [ ! -r "${element}" ]; then
                # jeśli obiekt nie ma prawa odczytu

                # do usunięcia początkuścieżki './dane/' można również zastosować usuwanie wzoraca jak w zad 8
                echo "${element}" | cut -c 8-;
            fi
        elif [ -d "${element}" ]; then
            # jeśłi obiekt jest katalogiem 

            find_files "${element}";
        fi
    done;
}

find_files "./dane/deep";