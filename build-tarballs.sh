#!/bin/bash
codes=('practica1 ficheros_p1.tar.gz' \
	'practica2 ficheros_p2.tar.gz' \
	'practica3 ficheros_p3.tar.gz' \
	'practica4 ficheros_p4.tar.gz' \
	'practica5 ficheros_p5.tar.gz')

codedir="../Codigos"
targetcodes="${PWD}"

ncodes=${#codes[@]}

selected_code=$1

if [ "${selected_code}" != "" ]; then
	filter_on=1
else
	filter_on=0
fi

for (( i=0 ; $i<$ncodes ; i++ ))
do
	items=(${codes[$i]})
	source_dir="${codedir}/${items[0]}/alumnos"
	target_file="${targetcodes}/${items[1]}"

	if [ ${filter_on} -eq 1 ] && [ "${selected_code}" != "${items[1]}" ]; then
		continue
	fi

	rm -f ${target_file}

    echo "Changing to directory: $source_dir"
    cd $source_dir
    echo "Building tarball: target_file"
    tar czvf ${target_file} *
    echo "Going back to current working directory"
    cd -
done

