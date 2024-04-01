#!/bin/bash

compile_cpp() {
    local source_file="$1"
    local output_executable="$2"

    start_time=$(date +%s)
    g++ -o "${output_executable}" "${source_file}"
    end_time=$(date +%s)

    if [ $? -eq 0 ]; then
        echo "Compiled ${source_file} successfully in $((end_time - start_time))s."
    else
        echo "Error compiling ${source_file}."
        exit 1
    fi
}

function stress_test() {
    local diff_found=0
    MAX_TESTS=$1

    for ((i=0; i<$MAX_TESTS; i++)); do
        ./testcase > input1.txt
        ./optimal < input1.txt > original_output.txt

        ./brute < input1.txt > brute_output.txt

        if diff -F --label --side-by-side --ignore-space-change original_output.txt brute_output.txt > /dev/null; then
            echo "test_case #$i:"
        else
            echo "test_case #$i: "
            diff_found=1
            break
        fi
    done

    if [[ $diff_found -eq 1 ]]
    then
        echo "Input: "
        cat input1.txt
        echo ""

        echo "Output(Main sol): "
        cat original_output.txt
        echo ""; echo ""

        echo "Expected(Brute sol): "
        cat brute_output.txt
        echo ""

        
    fi
    if [[ $diff_found -eq 0 ]]; then
        echo "All test cases passed!"
    fi

    echo "- - - - - - Testing Done - - - - - - "
}

main() {
    compile_cpp "brute.cpp" "brute"
    compile_cpp "optimal.cpp" "optimal"
    compile_cpp "testcase.cpp" "testcase"
    stress_test "$@"
}

main "$@"
