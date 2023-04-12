echo "Test av uppgift 3"
echo

fail=false
currtest=1

numtests=7

output=$(java -jar mars.jar a ae1 nc uppg3/solution.asm)
if [ $? -eq 0 ]; then
  echo "[$currtest/$numtests] Ok: Assemblering lyckades." 
else
  echo "[$currtest/$numtests] Fel: Assemblering lyckades inte."
    fail=true
fi

currtest=$((currtest+1))

output=$(java -jar mars.jar ae1 se2 nc uppg3/solution.asm)
if [ $? -eq 2 ]; then
  echo "[$currtest/$numtests] Fel: Körning av kompilerat program misslyckades."
  fail=true
else
  echo "[$currtest/$numtests] Ok: Körning av kompilerat program lyckades."
fi

currtest=$((currtest+1))

echo "array: 1 2 3 4 5"
echo "first: 0"
echo "last: 0"

product=1

echo "product: $product"

mv uppg3/data.asm uppg3/data.tmp
cat << EOF > uppg3/data.asm
.data
    array: .word 1 2 3 4 5	# räckan
    first: .word 0	# index för startvärde
    last: .word 0 # index för slutvärde
EOF

#cat uppg3/data.asm

output=$(java -jar mars.jar nc v0 v1 dec uppg3/solution.asm)
code=$?

expected_output=$(printf "\r\n\$v0\t%d\r\n\$v1\t0" $product )

rm uppg3/data.asm
mv uppg3/data.tmp uppg3/data.asm

if [ "$(echo -n "$output" | tr -d '\r\n')" = "$(echo -n "$expected_output" | tr -d '\r\n')" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad. Förväntat \"$expected_output\" fick \"$output\"."
else
  echo "[$currtest/$numtests] Fel: Förväntat \"$expected_output\" men fick \"$output\"."
  fail=true
fi


currtest=$((currtest+1))

echo "array: 1 2 3 4 5"
echo "first: 1"
echo "last: 0"

product=1

echo "product: $product"

mv uppg3/data.asm uppg3/data.tmp
cat << EOF > uppg3/data.asm
.data
    array: .word 1 2 3 4 5	# räckan
    first: .word 1	# index för startvärde
    last: .word 0 # index för slutvärde
EOF

#cat uppg3/data.asm

output=$(java -jar mars.jar nc v1 dec uppg3/solution.asm)
code=$?

expected_output=$(printf "\r\n\$v1\t1" $product )

rm uppg3/data.asm
mv uppg3/data.tmp uppg3/data.asm

if [ "$(echo -n "$output" | tr -d '\r\n')" = "$(echo -n "$expected_output" | tr -d '\r\n')" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad. Förväntat \"$expected_output\" fick \"$output\"."
else
  echo "[$currtest/$numtests] Fel: Förväntat \"$expected_output\" men fick \"$output\"."
  fail=true
fi

currtest=$((currtest+1))

echo "array: 1 2 0 4 5"
echo "first: 1"
echo "last: 3"

product=0

echo "product: $product"

mv uppg3/data.asm uppg3/data.tmp
cat << EOF > uppg3/data.asm
.data
    array: .word 1 2 0 4 5	# räckan
    first: .word 1	# index för startvärde
    last: .word 3 # index för slutvärde
EOF

#cat uppg3/data.asm

output=$(java -jar mars.jar nc v0 dec uppg3/solution.asm)
code=$?

expected_output=$(printf "\r\n\$v0\t%d" $product )

rm uppg3/data.asm
mv uppg3/data.tmp uppg3/data.asm

if [ "$(echo -n "$output" | tr -d '\r\n')" = "$(echo -n "$expected_output" | tr -d '\r\n')" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad. Förväntat \"$expected_output\" fick \"$output\"."
else
  echo "[$currtest/$numtests] Fel: Förväntat \"$expected_output\" men fick \"$output\"."
  fail=true
fi


currtest=$((currtest+1))

echo "array: -1 2 1 -4 5"
echo "first: 2"
echo "last: 4"

product=-20

echo "product: $product"

mv uppg3/data.asm uppg3/data.tmp
cat << EOF > uppg3/data.asm
.data
    array: .word -1 2 1 -4 5	# räckan
    first: .word 2	# index för startvärde
    last: .word 4 # index för slutvärde
EOF

#cat uppg3/data.asm

output=$(java -jar mars.jar nc v0 dec uppg3/solution.asm)
code=$?

expected_output=$(printf "\r\n\$v0\t%d" $product )

rm uppg3/data.asm
mv uppg3/data.tmp uppg3/data.asm

if [ "$(echo -n "$output" | tr -d '\r\n')" = "$(echo -n "$expected_output" | tr -d '\r\n')" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad. Förväntat \"$expected_output\" fick \"$output\"."
else
  echo "[$currtest/$numtests] Fel: Förväntat \"$expected_output\" men fick \"$output\"."
  fail=true
fi


currtest=$((currtest+1))

sizeA=10
A=$(seq -10 10|shuf -n $sizeA -r)
first=$(shuf -i 0-$((sizeA-2)) -n 1)
last=$(shuf -i $((first+1))-$((sizeA-1)) -n 1)
echo "array: $(echo $A)"
echo "first: $first"
echo "last: $last"

readarray -t arrA <<< $A
product=1

for (( i=$first; i<=$last; i++ ))
do
  product=$(( product * ${arrA[$i]} ))
done

echo "product: $product"

mv uppg3/data.asm uppg3/data.tmp
cat << EOF > uppg3/data.asm
.data
    array: .word $(echo $A)	# räckan
    first: .word $first	# index för startvärde
    last: .word $last # index för slutvärde
EOF

#cat uppg3/data.asm

output=$(java -jar mars.jar nc v0 dec uppg3/solution.asm)
code=$?

expected_output=$(printf "\r\n\$v0\t%d" $product )

rm uppg3/data.asm
mv uppg3/data.tmp uppg3/data.asm

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