echo "Test av uppgift 1"
echo

fail=false
currtest=1

numtests=3

output=$(java -jar mars.jar a ae1 nc uppg1/solution.asm)
if [ $? -eq 0 ]; then
  echo "[$currtest/$numtests] Ok: Assemblering lyckades." 
else
  echo "[$currtest/$numtests] Fel: Assemblering lyckades inte."
    fail=true
fi

currtest=$((currtest+1))

output=$(java -jar mars.jar ae1 se2 nc uppg1/solution.asm)
if [ $? -eq 2 ]; then
  echo "[$currtest/$numtests] Fel: Körning av kompilerat program misslyckades."
  fail=true
else
  echo "[$currtest/$numtests] Ok: Körning av kompilerat program lyckades."
fi

currtest=$((currtest+1))

output=$(java -jar mars.jar ae1 nc uppg1/solution.asm)
code=$?
expected_output="Hello world!"

if [ "$output" == "$expected_output" ] ; then
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