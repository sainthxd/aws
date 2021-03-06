#!/bin/bash
id="hxd"
mkdir -p /tmp/$id/mutli
host=`hostname`
pwd=`pwd`
uid=`whoami`
put_dir="/tmp/movies_wav_put"
mkdir -p  ${put_dir}/mutli
cd "/tmp/$id"
true > a

while read line; do
  input=$line
  filename=$input
  echo $filename
  echo "$uid@$host> hadoop fs -get $input /tmp/$id$filename"
  /home/hxd/Public/hadoop-1.0.4/bin/hadoop fs -get "$input" "/tmp/$id$filename" 2>&1
  echo "ffmpeg -i '/tmp/$id$filename' -f mp3 -vn '${put_dir}${filename}'.mp3"
  ffmpeg -i "/tmp/$id$filename" -vn -acodec pcm_s16le -ar 16000 -ac 1 "${put_dir}${filename}.wav"
  /home/hxd/Public/hadoop-1.0.4/bin/hadoop fs -put "${put_dir}$filename.wav" "/mutli_movie_wav${filename}.wav" 2>&1
  #echo "\$uid@\$host> hadoop fs -chown \$id \${put_dir}/output-\$filename.3gp"
  #hadoop fs -chown \$id \${put_dir}/output-\$filename.3gp 2>&1
 
done
rm -rf /tmp/$id

