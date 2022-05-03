EMPTY_LIST="empty_list.txt"
RESULT_ROOT="data"
CATEGORIES_FILE="categories.txt"
LIMIT_LINES="25"
TIMEOUT="2"		# second

if [ "$1" ] 
then
	CATEGORIES_FILE="$1"
fi

rm -rf $RESULT_ROOT;
rm $EMPTY_LIST

echo "Download from file $CATEGORIES_FILE"

mkdir data;
while read object; 
do 
	echo "Downloading $object..."; 
	fileUrlParam="${object// /%20}"
	fileName="$RESULT_ROOT/$object"
	
	curl -m $TIMEOUT "https://storage.googleapis.com/quickdraw_dataset/full/simplified/$fileUrlParam.ndjson" >> "$fileName"

	if [ -s "$fileName" ]
	then
	 	sed "1,$LIMIT_LINES!d" "$fileName" > "$fileName.ndjson" 
	else
		echo "$object" >> $EMPTY_LIST
	fi
	rm "$fileName"
done < $CATEGORIES_FILE