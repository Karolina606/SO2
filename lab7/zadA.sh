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
# Zadanie 10.
# Proszę opracować uproszczony konwerter plików z formatu JSON do formatu XML
# i przetworzyć nim plik `dodatkowe/simple.json`. Zakładamy, że wejście stanowi
# zawsze pojedyncza linia, klucze i wartości to proste łańcuchy znaków, złożone
# z liter lub cyfr, pomiędzy cudzysłowami, które są rozdzielone jednym znakiem
# dwukropka i co najmniej jedną spacją, a całe pary klucz-wartość są oddzielone
# od siebie jednym przecinkiem i co najmniej jedną spacją.
#
# Przykład przetworzenia: {"klucz": "wartość"} -> <klucz>wartość</klucz>.
#
# Proszę obsłużyć tworzenie samodomykającego się znacznika (<klucz />), kiedy
# wartość stanowi pusty łańcuch "", a także proszę obsłużyć zagnieżdżenie
# kolejnego zbioru kluczy i wartości.
#

awk --re-interval 'BEGIN{}
{
    gsub("^{|}$|\"|,", "", $0);
    gsub("{", "{ ", $0);
    gsub("}", " }", $0);
    gsub(" {1,}", " ", $0);
    split($0, tab, ",| ");
    bracket_open = 0;

    for (key = 0; key < length(tab); key++){

        # Sprawdzamy czy kolejny element jest kluczem, ma ":"
        if (match(tab[key], /.*:/)){
            sub(":", "", tab[key])

            # Jeśli nie ma jeszcze otwartego znacznika otwórz go pod jedynką i oznacz jako pusty (chwilowo)
            if(opened[1] == ""){
                opened[1] = tab[key];
                empty = 1;
            
            # Jeśli jakiś znaczniik jest już otwarty, otworz nowy pod dwójką jeśli można
            }else if(opened[2] == ""){
                
                # Jeśli jedynka jest zajęta i nie jesteśmy wewnątrz nawiasu
                if(opened[1] != "" && bracket_open == 0){
                   
                   # Jeśli znacnzik nie był pusty, zamknij znacznik i nadaj nowemu znacznikowi status otwarty
                    if (empty == 0){
                        printf("</%s>", opened[1]);
                        opened[1] = tab[key];
                        empty = 1;
                    }

                    # Jeśli był pusty to wypisz znak pustego znacznika i przypisz pod pierwszy otwarty znacnzik aktualny element
                    else{
                        printf("<%s />", opened[1]);
                        opened[1] = tab[key];
                    }

                # Jeśli jedynka i dwójka zajęta oraz nawias jest otwarty to nadpisz dwójkę i wyświetl (dla uproszczenia)
                }else{
                    opened[2] = tab[key];
                    printf("<%s>", opened[2]);
                }
            #Jeśli jedynka i dwójka zajęte
            }else{
                printf("</%s>", opened[2]);
                opened[2] = tab[key];
                printf("<%s>", opened[2]);
            }

        # Jeśli otwierany jest nawias, to wyświetl znacnzik otwierający elementu oraz przypisz mu status niepusty
        } else if(tab[key] == "{"){

            if(empty == 1){
                empty = 0;
                printf("<%s>", opened[1]);
            }

            bracket_open = 1;

        # Jeśli nawias zamykający, wypisz elementy zamykające tak jak potrzeba
        } else if(tab[key] == "}"){
            bracket_open = 0;

            if(opened[2] != ""){
                printf("</%s>", opened[2]);
                opened[2] = "";

            } else if(opened[1] != ""){
                printf("</%s>", opened[1]);

                if(opened[2] != ""){
                    opened[1] = opened[2];
                    opened[2] = ""; 
                }else{
                    opened[1] = "";
                }
            }
        } else{
            if(empty == 1){
                empty = 0;
                printf("<%s>", opened[1]);
            }
            printf("%s", tab[key]);
        }
    }
}END{
    if(opened[1] != "" && bracket_open == 0){
        printf("</%s>", opened[1]);
        opened[1] = "";
    }
}' dodatkowe/simple.json