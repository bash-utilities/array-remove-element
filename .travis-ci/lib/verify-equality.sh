#!/usr/bin/env bash


##
#
verify_equality() {
    local -a _arguments=("${@}")
    for i in "${!_arguments[@]}"; do
        case "${_arguments[${i}]}" in
            --target|-t)
                let i++
                local -n _target_reference="${_arguments[${i}]}"
                local _target_reference_name="${_arguments[${i}]}"
            ;;
            --expected|-e)
                let i++
                local -n _expected_reference="${_arguments[${i}]}"
                local _expected_reference_name="${_arguments[${i}]}"
            ;;
        esac
    done

    (("${#_target_reference_name}")) || {
        local -a message=( "${FUNCNAME[0]} needs '--target' paramater defined" )
        print_error message
    }

    (("${#_expected_reference_name}")) || {
        local -a message=( "${FUNCNAME[0]} needs '--expected' paramater defined" )
        print_error message
    }

    [[ "${#_target_reference[@]}" == "${#_expected_reference[@]}" ]] || {
        local -a message=(
            "Error: ${_target_reference_name} and ${_expected_reference_name} lengths do not match"
            "       \${#${_target_reference_name}[@]} -> ${#_target_reference[@]}"
            "       \${${_target_reference_name}[*]} -> ${_target_reference[*]}"
            '       -------'
            "       \${#${_expected_reference_name}[@]} -> ${#_expected_referance[@]}"
            "       \${${_expected_reference_name}[*]} -> ${_expected_referance[*]}"
        )
        print_error message
    }

    for i in "${!_target_reference[@]}"; do
        [[ "${_target_reference[${i}]}" == "${_expected_reference[$i]}" ]] || {
            local -a message=(
                'Error: list elements do not match'
                "       \${${_target_reference_name}[${i}]} -> ${_target_reference[${i}]}"
                "       \${${_expected_reference_name}[${i}]} -> ${_expected_referance[${i}]}"
            )
            print_error message
            return 1
        }
    done
}
