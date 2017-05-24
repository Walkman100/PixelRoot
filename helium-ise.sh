mkdir carbon
for i in `ls split-ab`; do
    mkdir carbon/${i::-3}
    cp split-ab/$i carbon/${i::-3}/$i
    echo "{\"packageName\":\"${i::-3}\"}" > carbon/${i::-3}/${i::-3}.json
done
