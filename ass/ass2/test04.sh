#!/bin/sh

# test for sub_function

numbers() {
    echo $number
    test $((number / 2)) -gt 5 && return 0
    return 0
}