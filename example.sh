#!/usr/bin/env bash


__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"


## Provides array_splice '<list_ref>' '<item>' '<offset>'
source "${__DIR__}/modules/array-splice/array-splice.sh"


list_items_print() {
    local -n _list="${1:?No list referance provided}"
    local _indent="${2:0}"
    local _padding=''
    ((_indent)) && {
        while [[ "${#_padding}" -lt "${_indent}" ]]; do
            _padding+=' '
        done
    }

    for i in "${!_list[@]}"; do
        printf '%s_list[%i] -> %s\n' "${_padding}" "${i}" "${_list[${i}]}"
    done
}


echo '--- list_one ---'

list_one=(
    --beginning "foo"
    --middle 'bar'
    --end 'spam'
)

list_items_print 'list_one' 4
echo "#> array_splice -t 'list_one' -e '--middle' -o 1"
array_splice -t 'list_one' -e '--middle' -o 1
list_items_print 'list_one' 4


echo '--- list_two ---'

list_two=(
    spam
    flavored
    ham
)

list_items_print 'list_two' 4
echo "#> array_splice -t 'list_two' -e 'flavored'"
array_splice -t 'list_two' -e 'flavored'
list_items_print 'list_two' 4


echo '--- list_three ---'


list_three=(
    lamb
    jam
    spam
    flavored
    ham
)

list_items_print 'list_three' 4
echo "#> array_splice -t 'list_three' -e 'flavored' -o -1"
array_splice -t 'list_three' -e 'flavored' -o -1
list_items_print 'list_three' 4


