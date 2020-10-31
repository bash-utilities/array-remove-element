#!/usr/bin/env bash


##
#
tests__regexp_negitive_offset() {
    printf 'Started: %s\n' "${FUNCNAME[0]}"
    local -a source_list=( --zero 0 --stringy "two three" four )
    local -a expected_list=( --stringy "two three" four )
    print_array source_list

    local -a deleted_expected
    local -a deleted_list

    local -a test_one=( "${source_list[@]}" )
    array_splice --target test_one --deleted deleted_list --regexp '^[0-9].*$' --offset -1
    verify_equality --target test_one --expected expected_list || {
        local _status="${?}"
        print_array test_one
        print_array expected_list
        return "${_status}"
    }

    deleted_expected+=( --zero 0 )
    verify_equality --target deleted_list --expected deleted_expected || {
        local _status="${?}"
        print_array deleted_expected
        print_array deleted_list
        return "${_status}"
    }

    ##
    #
    local -a test_two=( "${source_list[@]}" )
    local -a expected_list=( --zero 0 four )

    array_splice --target test_two --deleted deleted_list --regexp '^[[:print:]].*[[:space:]].*[[:print:]].*$' --offset -1
    verify_equality --target test_two --expected expected_list || {
        local _status="${?}"
        print_array test_two
        print_array expected_list
        return "${_status}"
    }

    deleted_expected+=( --stringy "two three" )
    verify_equality --target deleted_list --expected deleted_expected || {
        local _status="${?}"
        print_array deleted_expected
        print_array deleted_list
        return "${_status}"
    }

    printf 'Finished: %s\n' "${FUNCNAME[0]}"
}
