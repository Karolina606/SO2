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
# Zadanie 9.
# Odszukać w katalogu `dane/` i jego bezpośrednich podkatalogach (uwzględnić
# tylko jeden poziom wgłąb) wszystkie wiszące dowiązania miękkie i podjąć próbę
# ich naprawy – zakładamy, że nazwy wskazywanych przez nie plików są poprawne,
# ale doszło do jakiegoś zamieszania w strukturze katalogów. Należy odszukać
# pasujących plików zwykłych, a jeśli takie istnieją – wyświetlić nazwę
# dowiązania, dwukropek i po spacji: najkrótszą poprawną ścieżkę względną
# do niego od istniejącego dowiązania (na przykład: bravo: ../icao/bravo).
#

IFS=$'\n'
to_remove=$'\n'
cd dane;

look_for_nonsens_links(){
    if [ -L "${1}" ]; then
        pointed_path=$(readlink ${1});

        # dla każdego dowiązania miekkiego sprawdzamy czy nie jest wiszące
        if [ ! -e "${pointed_path}" ]; then
            file_basename=`basename "${1}"`
            # jesli jest wiszące to znajdź od katalogu /dane wszystkie o tej samej nazwie
            corrected=`find /home/karolina/Desktop/studejszyn_sem6/SO2/lab3/dane  -name "${file_basename}"`
            
            # tworzymy plik w którym chwilwo będą zapisane nazwy danych plików
            touch corrected_file
            echo "${corrected}" > corrected_file

            # czytamy każdą linię z pliku, co za tym idzie każda lokalizację pliku o konkretnej nazwie
            while read -r line 
            do
                # czy lokalizacja serio istnieje
                if  [ -e "${line}" ]; then
                    if [ ! "${1}" = "${line}" ]; then 
                        # jeśli ścieżka jest inna niż ścieżka aktualnego dowiązania

                        # to popraw tą ścieżkę, aby wskazywała lokację od aktualnej
                        corrected=$(realpath --relative-to=/$(pwd) "${line}");

                        echo `basename "${1}"`": ${corrected}";
                    fi
                fi
            done < corrected_file
            rm corrected_file;
        fi
    fi
}


for file in `ls`; do
    # przeszukujemy najpierw folder /dane
    look_for_nonsens_links "${file}"

    if [ -d "${file}" ]; then
        # przejdź do katalogu na pierwszej głębokości
        cd "${file}";

        for file2 in `ls`; do
            # sprawdź czy linki na pierwszej głebokości są wiszące i zajmij się nimi
            look_for_nonsens_links "${file2}"
        done

        cd ..;
    fi
done
cd ..

###################################### REDUNDANTNY KOD ######################################
# for file in `ls`; do
#     # przeszukujemy najpierw folder /dane
#     if [ -L "${file}" ]; then
#         pointed_path=$(readlink ${file});

#         # dla każdego dowiązania miekkiego sprawdzamy czy nie jest wiszące
#         if [ ! -e "${pointed_path}" ]; then
#             file_basename=`basename "${file}"`
#             # jesli jest wiszące to znajdź od katalogu /dane wszystkie o tej samej nazwie
#             corrected=`find /home/karolina/Desktop/studejszyn_sem6/SO2/lab3/dane  -name "${file_basename}"`
            
#             # tworzymy plik w którym chwilwo będą zapisane nazwy danych plików
#             touch corrected_file
#             echo "${corrected}" > corrected_file

#             while read -r line 
#             do
#                 if  [ -e "${line}" ]; then
#                     if [ ! "${file}" = "${line}" ]; then 
#                     corrected=$(realpath --relative-to=/$(pwd) "${line}");

#                     echo `basename "${file}"`": ${corrected}";
#                     fi
#                 fi
#             done < corrected_file
#             rm corrected_file;
#         fi
#     fi

#     if [ -d "${file}" ]; then
#         cd "${file}";

#         for file2 in `ls`; do
#             if [ -L "${file2}" ]; then
#                 pointed_path=$(readlink ${file2});
#                 if [ ! -e "${pointed_path}" ]; then

#                     file_basename=`basename "${file2}"`
#                     corrected=`find /home/karolina/Desktop/studejszyn_sem6/SO2/lab3/dane  -name "${file_basename}"`

#                     touch corrected_file
#                     echo "${corrected}" > corrected_file

#                     while read -r line 
#                     do
#                         if  [ -e "${line}" ]; then
#                             if [ ! "${file2}" = "${line}" ]; then 
#                             # echo $line
#                             corrected=$(realpath --relative-to=/$(pwd) "${line}");
#                             # echo "CORRECTED ${corrected}"

#                             echo `basename "${file2}"`": ${corrected}";
#                             # echo;
#                             fi
#                         fi
#                     done < corrected_file
#                     rm corrected_file;
#                 fi
#             fi
#         done

#         cd ..;
#     fi
# done
# cd ..



###################################### NIEUDANE PRÓBY ######################################
# cd dane/; 
# for file in `find -L . -maxdepth 2 -xtype l`; do
#     pointed_path=$(readlink ${file});
    
#     # echo `basename "${file}"` ": ${pointed_path} ##############################";

#     if [ ! -f "${pointed_path}" ]; then
#         echo `basename "${file}"` ": ${pointed_path}";
#     fi

#     echo
# done
# # cd .. ;


# IFS=$'\n'

# cd dane/; 
# for file in `find . -maxdepth 2 -xtype l`; do
#     pointed_path=$(readlink ${file});
#     # echo `basename "${file} ----"`;
#     # echo "`basename "${pointed_path}"` ##############" 

#     if [ ! -e "${pointed_path}" ]; then
#         pointed_path_basename=`basename "${pointed_path}"`
#         found_file=`find . -name "${pointed_path_basename}" -type f`
#         # echo `basename "${file} 111111"`;
#         # echo "found ${found_file} 22222222"
    
#         # if [ -e "${found_file}" ] && [ ! "${found_file}" = "" ]; then
#             corrected=$(realpath --relative-to=/$(dirname "${file}") $(basename "${file}"));
#             echo $(basename $(dirname "${file}"))
#             # echo "${corrected}"
#             echo `basename "${file}"` ":${corrected}";
#         # fi

#         # echo
#     fi 
    
# done
# cd .. ;
