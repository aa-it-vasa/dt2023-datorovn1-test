echo "Test av uppgift 2"
echo

fail=false
currtest=1

numtests=3

output=$(java -jar mars.jar a ae1 nc uppg2/solution.asm)
if [ $? -eq 0 ]; then
  echo "[$currtest/$numtests] Ok: Assemblering lyckades." 
else
  echo "[$currtest/$numtests] Fel: Assemblering lyckades inte."
    fail=true
fi

currtest=$((currtest+1))

output=$(java -jar mars.jar ae1 se2 nc uppg2/solution.asm)
if [ $? -eq 2 ]; then
  echo "[$currtest/$numtests] Fel: Körning av kompilerat program misslyckades."
  fail=true
else
  echo "[$currtest/$numtests] Ok: Körning av kompilerat program lyckades."
fi

currtest=$((currtest+1))

sizeA=11
sizeB=12
A=$(shuf -i 0-99 -n $sizeA)
B=$(shuf -i 0-$((sizeA-1)) -n $sizeB)
g=$(echo $((1 + $(shuf -i 0-999 -n 1))))
h=$(echo $((1 + $(shuf -i 0-999 -n 1))))
echo "A: $(echo $A)"
echo "B: $(echo $B)"
echo "g: $g"
echo "h: $h"

readarray -t arrA <<< $A
readarray -t arrB <<< $B

echo "B[4]: ${arrB[4]}"
echo "A[${arrB[4]}]: ${arrA[${arrB[4]}]}"
e=$(($g+$h+${arrB[4]}))
f=$(($g-${arrA[${arrB[4]}]}))
echo "e: $e"
echo "f: $f"

mv uppg2/data.asm uppg2/data.tmp
cat << EOF > uppg2/data.asm
.data
    g: .word $g
    h: .word $h
    A: .word $(echo $A)
    B: .word $(echo $B)
EOF

cat uppg2/data.asm

output=$(java -jar mars.jar nc t0 t1 dec uppg2/solution.asm)
code=$?
expected_output=$(printf "\r\n\$t0\t%s\r\n\$t1\t%s" $e $f)

rm uppg2/data.asm
mv uppg2/data.tmp uppg2/data.asm

if [ "$(echo -n "$output" | tr -d '\r\n')" = "$(echo -n "$expected_output" | tr -d '\r\n')" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad. Förväntat \"$expected_output\" fick \"$output\"."
else
  echo "[$currtest/$numtests] Fel: Förväntat \"$expected_output\" men fick \"$output\"."
  fail=true
fi

echo

if [ "$fail" = true ]; then
  echo "Misslyckades med något av testen!"
  exit 1
else
  echo "Klarade alla test!"
  exit 0
fi