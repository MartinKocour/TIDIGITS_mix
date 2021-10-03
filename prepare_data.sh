#!/bin/bash
#
# Author: Martin Kocour <ikocour@fit.vutbr.cz>
#

TIDIGITS="" # path/to/TIDIGITS

if [ -z "$TIDIGITS" ]; then
    echo "Please specify TIDIGITS variable inside the script: \"$0\""
    exit 1
fi

echo "Loading original data from $TIDIGITS" && (
    set -euxo pipefail
    for audio_f in `find $TIDIGITS -name "*.wav"`
    do
        file=`basename $audio_f`
        id=`basename $(dirname $audio_f)`
        gender=`basename $(dirname $(dirname $audio_f))`
        dataset=`basename $(dirname $(dirname $(dirname $audio_f)))`
        dir=$dataset/$gender/$id
        mkdir -p $dir
        sph2pipe -f wav $audio_f | sox -t wav - -t wav -r16000 -b16 $dir/$file
    done
)


echo "Preparing mixed data" && (
    set -euxo pipefail
    cat mix/prep/2spkrs/test.lst mix/prep/2spkrs/train.lst | while read line
    do
        audio_f1=`echo $line | cut -d' ' -f1`
        audio_f2=`echo $line | cut -d' ' -f2`
        uid1=$(basename $audio_f1 .wav)
        uid2=$(basename $audio_f2 .wav)
        sid1=`basename $(dirname $audio_f1)`
        sid2=`basename $(dirname $audio_f2)`
        gender1=`basename $(dirname $(dirname $audio_f1))`
        gender2=`basename $(dirname $(dirname $audio_f2))`
        dataset=`basename $(dirname $(dirname $(dirname $audio_f1)))`
        result_f="mix/wav/2spkrs/$dataset/${gender1}_${gender2}/${sid1}_${sid2}/${gender1}_${sid1}_${uid1}-${gender2}_${sid2}_${uid2}.wav"
        mkdir -p $(dirname $result_f)
        sox orig/$audio_f1 orig/$audio_f2 --combine mix $result_f
    done 
)

