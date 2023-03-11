#!/bin/bash

wget https://lhapdf.hepforge.org/downloads/?f=LHAPDF-6.3.0.tar.gz -O LHAPDF.tar.gz
tar xzf nnpdf40_nnlo_as_01180.tar.gz

# Read expected values from CSV file
EXPECTED_VALUES=$(cat expected_values.csv)

# Loop over expected values and compare with actual values
for VALUE in $EXPECTED_VALUES
do
    ID=$(echo $VALUE | cut -d',' -f1)
    X=$(echo $VALUE | cut -d',' -f2)
    Q=$(echo $VALUE | cut -d',' -f3)
    EXPECTED=$(echo $VALUE | cut -d',' -f4)
    ACTUAL=$(pdf.xfxQ $ID $X $Q)
    if [ $ACTUAL != $EXPECTED ]; then
        echo "Test failed: PDF value for ID=$ID, x=$X, Q=$Q is $ACTUAL, expected $EXPECTED"
        exit 1
    fi
done

echo "All tests passed"
exit 0
