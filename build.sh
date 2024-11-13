#!/bin/bash
documents=('../index.md index' \
	'../entorno.md entorno' \
	'../entorno-vscode-docker.md entorno-vscode-docker' \
	'../make.md make' \
	'../linux_vm_guide.md linux_vm_guide' \
	'../practica1.md practica1' \
    '../practica2.md practica2' \
    '../practica3.md practica3' \
    '../practica4.md practica4' \
    '../practica5.md practica5' \
    '../practica6.md practica6' \
    '../practica7.md practica7' \
    '../practica7s.md practica7s' )

ndocs=${#documents[@]}

## Clone image directory
if [ -d img ]; then
	rm -rf img
fi

cp -rf ../img .

selected_document=$1

if [ "${selected_document}" != "" ]; then
	filter_on=1
else
	filter_on=0
fi

for (( i=0 ; $i<$ndocs ; i++ ))
do
	items=(${documents[$i]})
	source_file=${items[0]}
	target_file1=${items[1]}.html
	target_file2=${items[1]}.pdf

	if [ ${filter_on} -eq 1 ] && [ "${selected_document}" != "${items[1]}" ]; then
		continue
	fi

	echo "${source_file} --> ${target_file1}"
	pandoc ${source_file} -N --self-contained  --template pandoc-templates/idocs3.html-template.html --toc --highlight-style tango  -o ${target_file1}
	if [ ${source_file} != '../index.md' ]; then
		echo "${source_file} --> ${target_file2}"
		pandoc ${source_file} -N --toc --highlight-style tango -o ${target_file2}
	fi
done


rm -rf img
