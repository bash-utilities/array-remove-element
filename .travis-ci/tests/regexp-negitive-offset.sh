#!/usr/bin/env bash


##
#
tests__regexp_negitive_offset() {
    printf 'Started: %s\n' "${FUNCNAME[0]}"

    local -a deleted_expected
    local -a deleted_list

    ##
    #
    local -a test_one=( --zero 0 --one 1 --two 2 --three 3 --four 4 )
    print_array test_one
    local -a expected_list=( --one 1 --two 2 --three 3 --four 4 )

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
    local -a test_two=( --first one --second two --third three )
    print_array test_two
    local -a expected_list=( --second two --third three )

    array_splice --target test_two --deleted deleted_list --regexp '^[[:alnum:]].*$' --offset -1
    verify_equality --target test_two --expected expected_list || {
        local _status="${?}"
        print_array test_two
        print_array expected_list
        return "${_status}"
    }

    deleted_expected+=( --first one )
    verify_equality --target deleted_list --expected deleted_expected || {
        local _status="${?}"
        print_array deleted_expected
        print_array deleted_list
        return "${_status}"
    }

    printf 'Finished: %s\n' "${FUNCNAME[0]}"
}
