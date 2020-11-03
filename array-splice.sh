#!/usr/bin/env bash


##
# Removes element from array plus/minus offset
# @note - Run with "--help" flag to print usage
# @example
#   target=( 'one' 'two' 'three' )
#   removed=()
#
#   array_splice -t target -d removed
#
#   echo "target -> ( ${target[@]} )"
#   #> target -> ( one three )
#
#   echo "removed -> ( ${removed[@]} )"
#   #> removed -> ( two )
# @author S0AndS0
# @license AGPL-3.0
array_splice() {
    local __usage__
    read -r -d '' __usage__ <<EOF
Removes element from array plus/minus offset


## Parameters

-t    --target <ArrayReferance> ${_target_reference_name}

    {Required} - Target array reference to remove element(s) from


-d    --deleted <ArrayReferance> ${_deleted_reference_name}

    {Optional} - Array reference to append removed element(s) to


-o    --offset <number> ${_offset}

    {Optional} - Index offset, may be negative or positive default: 1


-e    --element <number|string> "${_element:-Some Value}"

    {Required} - Element , if "--index" or "--regexp" is not defined, value to remove from target array


-i    --index <number> ${_index:-0}

    {Required} - If "--element" or "--regexp" is not defined, indexed value to remove from target array


-r    --regexp <RegExp> "${_regexp:-^--[[:print:]].*}"

    {Required} - If "--element" or "--index" is not defined, regular expression to remove from target array


-v    --verbose ${_verbose:-0}

    {Optional} - Prints parsed options and results if flag is present


-h    --help ${_help}

    {Optional} - Prints this message if flag is present


## Example

    target=( 'one' 'two' 'three' )
    removed=()

    array_splice -s target -r removed -e two

    echo "target -> ( \${target[@]} )"
    #> target -> ( one three )

    echo "removed -> ( \${removed[@]} )"
    #> removed -> ( two )
EOF


    ##
    # Initialize locally scoped variables
    local _deleted_reference_name
    local _element
    local _help=0
    local _index
    local _offset=0
    local _regexp
    local _target_reference_name
    local _verbose

    local _head_slice_start
    local _tail_slice_end
    local _deleted_slice_start
    local _deleted_slice_end
    local _head_slice_end
    local _tail_slice_start


    ##
    # Parse parameters
    local -a _arguments=( "${@:?No arguments provided to ${FUNCNAME[0]}}" )
    local i
    for i in "${!_arguments[@]}"; do
        case "${_arguments[${i}]}" in
            --target|-t)
                (( i++ )) || true
                local -n _target_reference="${_arguments[${i}]}"
                local _target_reference_name="${_arguments[${i}]}"
            ;;
            --deleted|-d)
                (( i++ )) || true
                local -n _deleted_reference="${_arguments[${i}]}"
                local _deleted_reference_name="${_arguments[${i}]}"
            ;;
            --offset|-o)
                (( i++ )) || true
                _offset="${_arguments[${i}]}"
            ;;
            --index|-i)
                (( i++ )) || true
                _index="${_arguments[${i}]}"
            ;;
            --element|-e)
                (( i++ )) || true
                _element="${_arguments[${i}]}"
            ;;
            --regexp|-r)
                (( i++ )) || true
                _regexp="${_arguments[${i}]}"
            ;;
            --verbose|-v)
                local _verbose=1
            ;;
            --help|-h)
                local _help=1
            ;;
        esac
    done


    ##
    # Detect premature exit states
    if (( _help )); then
        printf '%s\n' "${__usage__}"
        return 0
    fi

    if ! (( ${#_element} )) && ! (( ${#_index} )) && ! (( ${#_regexp} )); then
        printf >&2 'Error: %s -> please define "--element" or "--index" or "--regexp" parameter\n' "${FUNCNAME[0]}"
        return 1
    fi

    if ! (( ${#_target_reference_name} )); then
        printf >&2 'Error: %s -> please define "--target" parameter\n' "${FUNCNAME[@]}"
        return 1
    fi


    ##
    # Set index variable if undefined
    if ! (( ${#_index} )); then
        for i in "${!_target_reference[@]}"; do
            if
                {
                    (( ${#_element} )) && [[ "${_target_reference[${i}]}" == "${_element}" ]]
                } || {
                    (( ${#_regexp} )) && [[ "${_target_reference[${i}]}" =~ ${_regexp} ]]
                }
            then
                if [[ "${_offset}" == 0 ]]; then
                    local _index="${i}"
                    break
                elif [[ "${_offset}" -gt 0 ]]; then
                    local _index="${i}"
                    break
                elif [[ "${_offset}" -lt 0 ]]; then
                    local _index="${i}"
                    break
                else
                    printf >&2 'Error: %s -> parameter "--offset" must numerical\n' "${FUNCNAME[0]}"
                    return 1
                fi
            fi
        done
    fi


    ##
    # Set slice variables
    if (( ${#_index} )); then
        local _head_slice_start="0"
        local _tail_slice_end="$((${#_target_reference[@]} - 1))"
        if [[ "${_offset}" == 0 ]]; then
            local _deleted_slice_start="${_index}"
            local _deleted_slice_end="$((_offset + 1))"
            local _head_slice_end="${_index}"
            local _tail_slice_start="$((_index + _offset + 1))"
        elif [[ "${_offset}" -gt 0 ]]; then
            local _deleted_slice_start="${_index}"
            local _deleted_slice_end="$((_offset + 1))"
            local _head_slice_end="${_index}"
            local _tail_slice_start="$((_index + _offset + 1))"
        elif [[ "${_offset}" -lt 0 ]]; then
            local _deleted_slice_start="$((_index + _offset))"
            local _deleted_slice_end="$((_offset * -1 + 1))"
            local _head_slice_end="$((_index + _offset))"
            local _tail_slice_start="$((_index + 1))"
        else
            printf >&2 'Error: %s -> parameter "--offset" must numerical\n' "${FUNCNAME[0]}"
            return 1
        fi
    else
        printf >&2 'Error: %s -> parameter "--index" undefined or variable "_index" not parced' "${FUNCNAME[0]}"
        return 1
    fi


    ##
    # Print parsed options and variables
    if (( _verbose )); then
        printf >&2 '## Parameter variables\n'
        if (( ${#_element} )); then
            printf >&2 '   _element -> %s\n' "${_element}"
        fi
        if (( ${#_index} )); then
            printf >&2 '   _index -> %i\n' "${_index}"
        fi
        if (( ${#_regexp} )); then
            printf >&2 '   _regexp -> %s\n' "${_regexp}"
        fi
        printf >&2 '   _offset -> %i\n' "${_offset}"
        printf >&2 '   _verbose -> %i\n' "${_verbose}"

        printf >&2 '## Slice variables\n'
        printf >&2 '   _deleted_slice_start -> %s\n' "${_deleted_slice_start}"
        printf >&2 '   _deleted_slice_end -> %s\n' "${_deleted_slice_end}"
        printf >&2 '   _head_slice_start -> %s\n' "${_head_slice_start}"
        printf >&2 '   _head_slice_end -> %s\n' "${_head_slice_end}"
        printf >&2 '   _tail_slice_start -> %s\n' "${_tail_slice_start}"
        printf >&2 '   _tail_slice_end -> %s\n' "${_tail_slice_end}"

        printf >&2 '## Array references before\n'
        # shellcheck disable=SC2016
        printf >&2 '   ${%s[*]} -> %s\n' "${_target_reference_name}" "${_target_reference[*]}"
        if (( ${#_deleted_reference_name} )); then
            # shellcheck disable=SC2016
            printf >&2 '   ${%s[*]} -> %s\n' "${_deleted_reference_name}" "${_deleted_reference[*]}"
        fi
    fi


    ##
    # Append to removed reference array and re-build target reference array
    if (( ${#_deleted_slice_start} )) && (( ${#_deleted_slice_end} )); then
        if (( ${#_deleted_reference_name} )); then
            _deleted_reference+=( "${_target_reference[@]:${_deleted_slice_start}:${_deleted_slice_end}}" )
        fi
        _target_reference=( "${_target_reference[@]:${_head_slice_start}:${_head_slice_end}}" "${_target_reference[@]:${_tail_slice_start}:${_tail_slice_end}}" )
    fi


    ##
    # Print resulting changes to array references
    if (( _verbose )); then
        printf >&2 '## Array references after\n'
        # shellcheck disable=SC2016
        printf >&2 '   ${%s[*]} -> %s\n' "${_target_reference_name}" "${_target_reference[*]}"
        if (( ${#_deleted_reference_name} )); then
            # shellcheck disable=SC2016
            printf >&2 '   ${%s[*]} -> %s\n' "${_deleted_reference_name}" "${_deleted_reference[*]}"
        fi
    fi
}

