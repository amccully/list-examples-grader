# Create your grading script here
FILENAME="ListExamples.java"
CPATH=".:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar"

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
if [ -e $FILENAME ]
then
    echo "$FILENAME found"
else
    echo "$FILENAME not found"
    echo "Grade: 0%"
    exit
fi
cd ..

cp TestListExamples.java student-submission
cd student-submission
# echo "$PWD"

javac -cp $CPATH $FILENAME
if [ $? -ne 0 ]
then
    echo "$FILENAME could not compile"
    echo "Grade: 0%"
    exit
else
    echo "Compiled"
fi
javac -cp $CPATH TestListExamples.java

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples | grep "Tests" > testResults.txt
OUTPUT=(`grep -o '[0-9]' < testResults.txt`)
PASSED=${OUTPUT[0]}
TOTAL=${OUTPUT[1]}
echo "Passed: $PASSED"
echo "Total: $TOTAL"
GRADE=$(bc <<< "scale=2 ; ($PASSED / $TOTAL)*100")
echo "Grade: $GRADE%"