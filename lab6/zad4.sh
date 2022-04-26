#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 6
#
# Celem zajęć jest zapoznanie się z możliwościami narzędzia awk.
#
# Tradycyjnie nie przywiązujemy zbyt dużej wagi do środowiska roboczego.
# Zakładamy, że format i układ danych w podanych plikach nie ulega zmianie,
# ale same wartości, inne niż podane wprost w treści zadań, mogą ulec zmianie,
# a przygotowane zadania wciąż powinny działać poprawnie (robić to, co trzeba).
#
# Wszystkie chwyty dozwolone, ale w wyniku ma powstać tylko to, o czym jest
# mowa w treści zadania – nie generujemy żadnych dodatkowych plików pośrednich.
# Większość rozwiązań powinno sprowadzić się do jednego, zmyślnego wywołania
# programu `awk` z odpowiednimi argumentami.
#

#
# Zadanie 4.
# Przeanalizować zawartość pliku `dodatkowe/ps-aux` i zliczyć sumaryczną
# procentowe użycie procesora oraz zajętość pamięci RAM. Odpowiednie dane
# znajdują się w trzeciej i czwartej kolumnie w pliku. Pamiętać o pominięciu
# nagłówka (pierwsza linia w pliku). Jako wynik zwrócić dwa napisy w osobnych
# liniach, a wartości liczbowe poprzedzić etykietą "CPU:" bądź "RAM:".
#
LC_NUMERIC="en_US.UTF-8";
awk 'BEGIN { FS = " ";  CPU=0.0 ; RAM=0.0}
    {  
        if ( NR != 1 ){
            CPU = CPU + $3;
            RAM = RAM + $4;
        }
    }
    END { 
        printf "CPU: %1.1f\n", CPU;
        printf "RAM: %1.1f\n", RAM;
    }' dodatkowe/ps-aux 
