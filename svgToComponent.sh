#!/bin/bash

read -r -p "📁 Enter the full path of the directory where your SVG files are placed: " path

# Check if the SVGs directory already exists
mkdir -p SVGs
cd SVGs

# Check if path provided is actually a path
if [[ -d "$path" ]]; then
   echo ""
else
    echo "Incorect path. Please run the script again. ❌"
    exit
fi

# Replace any \ found in the path with / 
formatDirectory () {
    echo $path | sed 's/\\/\//g'
}

# Remove the svg file extension from the file name
formatFileName () {
    echo "$(basename "$file")" | sed 's/.svg//g' | sed -E 's/-(.)/\u\1/g'
}

directory=$(formatDirectory)

createComponents() {
    for file in $directory/*; do
    organize=$1
    fileExt=$2
    rcType=$3

    fileName=$(formatFileName)
    fileNameCap="${fileName^}"

    # Decide if the export will be default or not
    [[ "$organize" == "multiple" ]] && exportType="default $fileNameCap" || exportType="{$fileNameCap}"

    component="const $fileNameCap$rcType = () => {
            return (
                # Write the svg
                $(<$file)
            )
        };
        export $exportType;"
    
    if [[ $organize = "multiple" ]]
    then 
        echo $component > $fileNameCap.$fileExt
    else 
        echo $component >> svgs.$fileExt
    fi
done
}



PS3=$'\nInsert a number from the menu above and press enter: '
echo "❔ Are you using TypeScript?"

select typeChecking in yes no
do
    case $typeChecking in
        "yes")
            fileExt="tsx"
            rcType=":React.FC"
            break;;
        "no")
            fileExt="jsx"
            rcType=""
            break;;
        *)
           echo "⚠️The number you enetered is not an option in the menu above. Please try again.";;
    esac
done



PS3=$'\nInsert a number from the menu above and press enter: '
echo -e "\n❔ Choose how to organize your SVG components"
organizingOptions=("multiple files" "single file")

select fun in "${organizingOptions[@]}"
do
    case $fun in
        "multiple files")
            createComponents "multiple" $fileExt $rcType
            break;;
        "single file")
            [[ -f svgs.$fileExt ]] && rm svgs.$fileExt
            createComponents "single" $fileExt $rcType
            break;;
        *)
           echo "⚠️The number you enetered is not an option in the menu above. Please try again.";;
    esac
done



echo -e "\nYour SVG files were sucesfuly transformed into components ✔️✨"
