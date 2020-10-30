#!/usr/bin/env bash


__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__PARENT_DIR__=$(dirname "${__DIR__}")

set -E -o functrace

## Provides array_splice '<list_ref>' '<item>' '<offset>'
# shellcheck source=array-splice.sh
source "${__PARENT_DIR__}/array-splice.sh"


## Provides verify_equality '<target_ref>' '<expected_ref>'
# shellcheck source=.travis-ci/lib/verify-equality.sh
source "${__DIR__}/lib/verify-equality.sh"

## Provides print_error '<message_ref>'
# shellcheck source=.travis-ci/lib/print-error.sh
source "${__DIR__}/lib/print-error.sh"

## Provides print_array '<array_ref>' '<padding_ammount>'
##          pad_string '<padding_ammount>' '<character>'
# shellcheck source=.travis-ci/lib/print-array.sh
source "${__DIR__}/lib/print-array.sh"


## Provides tests__undefined_offset
# shellcheck source=.travis-ci/tests/undefined-offset.sh
source "${__DIR__}/tests/undefined-offset.sh"

## Provides tests__element_positive_offset
# shellcheck source=.travis-ci/tests/element-positive-offset.sh
source "${__DIR__}/tests/element-positive-offset.sh"

## Provides tests__index_positive_offset
# shellcheck source=.travis-ci/tests/index-positive-offset.sh
source "${__DIR__}/tests/index-positive-offset.sh"

## Provides tests__regexp_positive_offset
# shellcheck source=.travis-ci/tests/regexp-positive-offset.sh
source "${__DIR__}/tests/regexp-positive-offset.sh"

## Provides tests__element_negitive_offset
# shellcheck source=.travis-ci/tests/element-negitive-offset.sh
source "${__DIR__}/tests/element-negitive-offset.sh"

## Provides tests__index_negitive_offset
# shellcheck source=.travis-ci/tests/index-negitive-offset.sh
source "${__DIR__}/tests/index-negitive-offset.sh"

## Provides tests__regexp_negitive_offset
# shellcheck source=.travis-ci/tests/regexp-negitive-offset.sh
source "${__DIR__}/tests/regexp-negitive-offset.sh"


##
#
test_function() {
    local _function_name="${1:?No function_name name provided}"
    "${_function_name}" || {
        local _status="${?}"
        printf 'Failed -> %s\n' "${_function_name}"
        return "${_status}"
    }
}


test_function tests__undefined_offset

test_function tests__element_positive_offset

test_function tests__index_positive_offset

test_function tests__regexp_positive_offset

test_function tests__element_negitive_offset

test_function tests__index_negitive_offset

test_function tests__regexp_negitive_offset

