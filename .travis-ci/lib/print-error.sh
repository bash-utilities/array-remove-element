#!/usr/bin/env bash


##
#
print_error() {
    local -n error_message="${1}"
    printf >&2 '%s\n' "${error_message[@]}"
}
