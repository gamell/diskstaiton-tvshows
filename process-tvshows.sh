#!/bin/sh

#Script for TvShows management

cd /volume1/Torrents/

# cleanup of "empty" folders
# du -s * outputs all the top folders and files with their respective size
# with grep we filter out the things we want to keep
# we delete anything left
	
du -s * | grep -v 'to-process\|pending\|cache\|@eaDir\|to-delete-test\|history.xml' | while read size filename; do
if [ $size -lt 5000 ]; then
#rm -rf "$filename"
mv "$filename" ./to-delete-test
fi
done
	
	# delete all files/folders which have "sample" in the name
find . -regex '\./.*\(sample\|SAMPLE\).*\.\(mkv\|avi\|mov\|mp4\|srt\)' -exec rm {} \;
	
	# find and move all mkv,avi,mov,mp4,srt to process folder
find . -regex '\./.*\(s\|S\)[0-9]+\(e\|E\)[0-9]+.*\.\(mkv\|avi\|mov\|mp4\|srt\)' -exec mv {} ./to-process \;
	
	# TODO: DELETE
	# move possibly missing srt
	#find . -regex '\./..*\.srt' -exec mv {} ./to-process \;
	
cd to-process
	
	# get missing subs
filebot -get-missing-subtitles ./
	
	# rename and move episodes
filebot -rename ./ --format '/volume1/Media/TvShows/{n}/Season{s}/{sxe}.{t}' -non-strict
	
	
	# cleanup of "empty" folders
	# du -s * outputs all the top folders and files with their respective size
	# with grep we filter out the things we want to keep
	# we delete anything left
		
du -s * | grep -v 'to-process\|pending\|cache\|@eaDir\|to-delete-test\|history.xml' | while read size filename; do
if [ $size -lt 5000 ]; then
#rm -rf "$filename"
mv "$filename" ../to-delete-test
fi
done
