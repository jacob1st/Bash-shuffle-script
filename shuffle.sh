#!/bin/bash

# Shuffles a directory by renaming all of the files starting with a random number
dir_to_shuffle=$1

# check if the user gave a directories
if [ -n "$dir_to_shuffle" ]; then
    full_path="$(readlink -e $dir_to_shuffle)"
else
    echo "Error: No given directory."
    echo "Usage: ./shuffle [directory]"
    exit
fi

# Confirm to shuffle
echo "Do you want to shuffle the contents of $full_path ?"
echo "Warning: Doing this will rename the beginning of all your files it is recommended to create a backup first"
echo "To shuffle this directory type 's', to create a backup and then shuffle type 'b', to close type 'e'" 
read confirmation
if [ $confirmation == "s" ]; then
    echo "Shuffling please wait..."
    ls ${full_path} | while read -r file; do rand_num=$((1 + $RANDOM % 100)); mv ${full_path}/${file} ${full_path}/${rand_num}${file}; done
    echo "Finished."
elif [ $confirmation == "b" ]; then
    echo ""
    echo "What would you like the shuffled directory to be called? (If the directory already exists, shuffled files will be added to it)"
    read shuffled_directory
    mkdir ${full_path}/${shuffled_directory}
    echo "Created new directory"
    echo "Shuffling please wait..."
    ls ${full_path} | while read -r file; do rand_num=$((1 + $RANDOM % 100)); cp ${full_path}/${file} ${full_path}/${shuffled_directory}/${rand_num}${file}; done
    echo "Finished. (The warning 'cp: -r not specified; omitting directory <some_path>/shuffled_directory' is OK)"
else
    echo "Not shuffling..."
fi
