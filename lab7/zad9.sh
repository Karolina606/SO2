#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 7
#
# Celem zajęć jest zapoznanie się z wyrażeniami regularnymi, wykorzystując
# przy tym narzędzia awk i grep oraz wszystkie inne, poznane na zajęciach.
#
# Tradycyjnie nie przywiązujemy zbyt dużej wagi do środowiska roboczego.
# Zakładamy, że format i układ danych w podanych plikach nie ulega zmianie,
# ale same wartości, inne niż podane wprost w treści zadań, mogą ulec zmianie,
# a przygotowane zadania wciąż powinny działać poprawnie (robić to, co trzeba).
#
# Wszystkie chwyty dozwolone, ale w wyniku ma powstać tylko to, o czym jest
# mowa w treści zadania – nie generujemy żadnych dodatkowych plików pośrednich.
#

#
# Zadanie 9.
# Proszę wyświetlić komentarze z bieżącego pliku z zadaniami ($0), wstawiając
# znaki niełamliwej spacji języka HTML (&nbsp;) zamiast zwykłych spacji
# za wszystkimi pojedynczymi literami w tekście.
#

awk --re-interval 'BEGIN{RS = "\n"}
{
    # printf "# "
    if (match($0, /^#/)){
        split($0, tab, " ")

        for (key = 0; key < length(tab); key++){

            if (length(tab[key]) == 1 && match(tab[key], /[a-z|A-Z]/ ) ){
                tab[key] = tab[key] "&nbsp;";
                printf "%s", tab[key];
                
            }else if (key < length(tab)-1 && key != 0){
                printf "%s ", tab[key];
                
            }else if (key == length(tab)-1 ){
                printf "%s\n", tab[key];
            }
        }
    }
}' $0