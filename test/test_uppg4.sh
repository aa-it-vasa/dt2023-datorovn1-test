echo "Test av uppgift 4"
echo

fail=false
currtest=1

numtests=6

output=$(java -jar mars.jar a ae1 nc uppg4/solution.asm)
if [ $? -eq 0 ]; then
  echo "[$currtest/$numtests] Ok: Assemblering lyckades." 
else
  echo "[$currtest/$numtests] Fel: Assemblering lyckades inte."
    fail=true
fi

currtest=$((currtest+1))

output=$(java -jar mars.jar ae1 se2 nc uppg4/solution.asm)
if [ $? -eq 2 ]; then
  echo "[$currtest/$numtests] Fel: Körning av kompilerat program misslyckades."
  fail=true
else
  echo "[$currtest/$numtests] Ok: Körning av kompilerat program lyckades."
fi


currtest=$((currtest+1))

random=0
tmprandom=random
echo "tal: $random"
echo "binär representation: $(perl -e 'printf "%b\n",'$random)"

count=0
for (( i = 0; i < 32; i++ )); do
  if (( $tmprandom & 1 )); then
    let "count += 1"
  fi
  let "tmprandom = tmprandom >> 1"
done

echo "bitcount: $count"

mv uppg4/data.asm uppg4/data.tmp
cat << EOF > uppg4/data.asm
.data
    x: .word $random
EOF

#cat uppg4/data.asm

output=$(java -jar mars.jar nc v0 dec uppg4/solution.asm)
code=$?

expected_output=$(printf "\r\n\$v0\t%d" $count )

rm uppg4/data.asm
mv uppg4/data.tmp uppg4/data.asm

if [ "$(echo -n "$output" | tr -d '\r\n')" = "$(echo -n "$expected_output" | tr -d '\r\n')" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad. Förväntat \"$expected_output\" fick \"$output\"."
else
  echo "[$currtest/$numtests] Fel: Förväntat \"$expected_output\" men fick \"$output\"."
  fail=true
fi

currtest=$((currtest+1))

random=1
tmprandom=random
echo "tal: $random"
echo "binär representation: $(perl -e 'printf "%b\n",'$random)"

count=0
for (( i = 0; i < 32; i++ )); do
  if (( $tmprandom & 1 )); then
    let "count += 1"
  fi
  let "tmprandom = tmprandom >> 1"
done

echo "bitcount: $count"

mv uppg4/data.asm uppg4/data.tmp
cat << EOF > uppg4/data.asm
.data
    x: .word $random
EOF

#cat uppg4/data.asm

output=$(java -jar mars.jar nc v0 dec uppg4/solution.asm)
code=$?

expected_output=$(printf "\r\n\$v0\t%d" $count )

rm uppg4/data.asm
mv uppg4/data.tmp uppg4/data.asm

if [ "$(echo -n "$output" | tr -d '\r\n')" = "$(echo -n "$expected_output" | tr -d '\r\n')" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad. Förväntat \"$expected_output\" fick \"$output\"."
else
  echo "[$currtest/$numtests] Fel: Förväntat \"$expected_output\" men fick \"$output\"."
  fail=true
fi

currtest=$((currtest+1))

random=$(shuf -i 0-10 -n 1)
tmprandom=random
echo "tal: $random"
echo "binär representation: $(perl -e 'printf "%b\n",'$random)"

count=0
for (( i = 0; i < 32; i++ )); do
  if (( $tmprandom & 1 )); then
    let "count += 1"
  fi
  let "tmprandom = tmprandom >> 1"
done

echo "bitcount: $count"

mv uppg4/data.asm uppg4/data.tmp
cat << EOF > uppg4/data.asm
.data
    x: .word $random
EOF

#cat uppg4/data.asm

output=$(java -jar mars.jar nc v0 dec uppg4/solution.asm)
code=$?

expected_output=$(printf "\r\n\$v0\t%d" $count )

rm uppg4/data.asm
mv uppg4/data.tmp uppg4/data.asm

if [ "$(echo -n "$output" | tr -d '\r\n')" = "$(echo -n "$expected_output" | tr -d '\r\n')" ] ; then
  echo "[$currtest/$numtests] Ok: Korrekt text returnerad. Förväntat \"$expected_output\" fick \"$output\"."
else
  echo "[$currtest/$numtests] Fel: Förväntat \"$expected_output\" men fick \"$output\"."
  fail=true
fi

currtest=$((currtest+1))

random=$(shuf -i 1111-9999 -n 1)
tmprandom=random
echo "tal: $random"
echo "binär representation: $(perl -e 'printf "%b\n",'$random)"

count=0
for (( i = 0; i < 32; i++ )); do
  if (( $tmprandom & 1 )); then
    let "count += 1"
  fi
  let "tmprandom = tmprandom >> 1"
done

echo "bitcount: $count"

mv uppg4/data.asm uppg4/data.tmp
cat << EOF > uppg4/data.asm
.data
    x: .word $random
EOF

#cat uppg4/data.asm

output=$(java -jar mars.jar nc v0 dec uppg4/solution.asm)
code=$?

expected_output=$(printf "\r\n\$v0\t%d" $count )

rm uppg4/data.asm
mv uppg4/data.tmp uppg4/data.asm

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