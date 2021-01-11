c_sum=0
asm_sum=0
if [ $1 ]; then
    SKEL_FOLDER=$1/ make > /dev/null
    echo $1
else
    SKEL_FOLDER=../sol/ make > /dev/null
    echo "Official solution"
fi

for i in {1..50}; do
    ./checker | grep "Speed-up" > result
    if [ $(cat result | wc -l) == "2" ]; then
        c_result=$(cat result | sed -n 1p | cut -d' ' -f6)
        c_sum=$(echo $c_sum + $c_result | bc)
        asm_result=$(cat result | sed -n 2p | cut -d' ' -f6)
        asm_sum=$(echo $asm_sum + $asm_result |bc)
    else
        cat result | grep "ASM" > result_asm
        cat result | grep "ASM" > result_c

        if [[ $(cat result_asm | wc -l) == "1" ]]; then
            asm_result=$(cat result_asm | cut -d' ' -f6)
            asm_sum=$(echo $asm_sum + $asm_result |bc)
        elif [[ $(cat result_c | wc -l) == "1" ]]; then
            c_result=$(cat result_c | cut -d' ' -f6)
            c_sum=$(echo $c_sum + $c_result |bc)
        fi
    fi
done

rm result result_c result_asm 2> /dev/null

python3 -c "print(\"C:\t%.4f\" % ($c_sum / 50))"
python3 -c "print(\"ASM:\t%.4f\" % ($asm_sum / 50))"

make clean > /dev/null