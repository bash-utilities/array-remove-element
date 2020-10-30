#!/usr/bin/env bash


##
#
tests__index_negitive_offset() {
    printf 'Started: %s\n' "${FUNCNAME[0]}"

    local -a source_list=( zero one two three four )
    local -a expected_list=( zero three four )
    print_array source_list

    local -a deleted_expected
    local -a deleted_list

    local -a test_one=( "${source_list[@]}" )
    array_splice --target test_one --deleted deleted_list --index 2 --offset -1
    verify_equality --target test_one --expected expected_list || {
        local _status="${?}"
        print_array test_one
        print_array expected_list
        return "${_status}"
    }

    deleted_expected+=( one two )
    verify_equality --target deleted_list --expected deleted_expected || {
        local _status="${?}"
        print_array deleted_expected
        print_array deleted_list
        return "${_status}"
    }

    printf 'Finished: %s\n' "${FUNCNAME[0]}"
}
