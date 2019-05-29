set -e

cur_dir=$(dirname $(readlink -m $0))

if [[ -e ~/.cheat ]]
then
    rm -rf ~/.cheat
fi

ln -s $cur_dir ~/.cheat
echo "$cur_dir --> ~/.cheat"

set +e
