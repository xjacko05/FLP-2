#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e -n "Running tests...\n"

echo -e -n "\tTest 1 - from assignment\t"
./flp22-log < tests/test1.in > tests/test1.real
if [[ $(diff tests/test1.out tests/test1.real) = "" ]]
then
    echo -e "${GREEN}PASS${NC}"
else
    echo -e "${RED}FAIL${NC}"
fi

echo -e -n "\tTest 2 - long (please wait)\t"
./flp22-log < tests/test2.in > tests/test2.real
if [[ $(diff tests/test2.out tests/test2.real) = "" ]]
then
    echo -e "${GREEN}PASS${NC}"
else
    echo -e "${RED}FAIL${NC}"
fi

echo -e -n "\tTest 3 - other\t\t\t"
./flp22-log < tests/test3.in > tests/test3.real
if [[ $(diff tests/test3.out tests/test3.real) = "" ]]
then
    echo -e "${GREEN}PASS${NC}"
else
    echo -e "${RED}FAIL${NC}"
fi

echo -e -n "Testing finished\n"