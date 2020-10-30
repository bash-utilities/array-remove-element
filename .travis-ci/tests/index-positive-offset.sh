#!/usr/bin/env bash


##
#
tests__index_positive_offset() {
    printf 'Started: %s\n' "${FUNCNAME[0]}"

    local -a source_list=( --one first --two second --three third )
    print_array source_list

    local -a deleted_expected
    local -a deleted_list
    local -a expected_list=( --one first --three third )

    local -a test_two=( "${source_list[@]}" )
    array_splice --target test_two --deleted deleted_list --index 2 --offset 1
    verify_equality --target test_two --expected expected_list || {
        local _status="${?}"
        print_array test_two
        print_array expected_list
        return "${_status}"
    }

    deleted_expected+=( --two second )
    verify_equality --target deleted_list --expected deleted_expected || {
        local _status="${?}"
        print_array deleted_expected
        print_array deleted_list
        return "${_status}"
    }

    ##
    #
    local -a test_two=( "${source_list[@]}" )
    expected_list=( --three third )
    array_splice --target test_two --deleted deleted_list --index 0 --offset 3
    verify_equality --target test_two --expected expected_list || {
        local _status="${?}"
        print_array test_two
        print_array expected_list
        return "${_status}"
    }

    deleted_expected+=( --one first --two second )
    verify_equality --target deleted_list --expected deleted_expected || {
        local _status="${?}"
        print_array deleted_expected
        print_array deleted_list
        return "${_status}"
    }

    printf 'Finished: %s\n' "${FUNCNAME[0]}"
}
