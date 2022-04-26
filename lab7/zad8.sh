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
# Zadanie 8.
# Przetworzyć zawartość pliku `dodatkowe/sensors.txt` i wyświetlić całą jego
# zawartość, ale podmieniając w locie zapisane tam wartości temperatur ze skali
# Celsjusza na Fahrenheita: T[°F] = T[°C] * 9/5 + 32.
#

# LC_NUMERIC="en_US.UTF-8";
# cat dodatkowe/sensors.txt | grep -oP '[\+|\-][0-9|.]*°C' | $(( `sed 's/[\+|°C]//g'` * 9/5 + 32 ));

awk --re-interval 'BEGIN{RS = "\nr"}
{
    split($0, tab, "+|°C", seps);
    for(i=1; i<=length(tab); i++) {

        if ( match( tab[i], /[0-9]+[.][0-9]*+/ ) ) {
            
            tab[i] = (tab[i] * 9/5 + 32);
            printf("%s%s%s%s"), tab[i-1], "+", tab[i], "°F";
        }
    }
}
END{
    printf(")");
}' dodatkowe/sensors.txt