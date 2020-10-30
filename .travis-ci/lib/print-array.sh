#!/usr/bin/env bash


##
#
pad_string() {
    local _limit="${1}"
    local _character="${2:- }"
    local _result=''

    for i in $(seq 0 "${_limit}"); do
        _result+="${_character}"
    done

    printf '%s' "${_result}"
}


##
#
print_array() {
    local -n _array_referance="${1}"
    local _array_referance_name="${1}"
    local _padding="$(pad_string "${2:-2}")"
    printf '%s${%s[*]} -> %s\n' "${_padding}" "${_array_referance_name}" "${_array_referance[*]}"
}
