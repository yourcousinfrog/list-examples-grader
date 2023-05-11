CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

# Step 1
git clone $1 student-submission
echo 'Finished cloning'

# Step 2
if [[ -e student-submission/ListExamples.java ]]
then 
    echo "File submitted successfully"
else
    echo "Incorrect file submitted, try again"
    exit 1
fi

# Step 3
cp -r student-submission/ListExamples.java grading-area
cp -r student-submission/lib grading-area
cp -r *.java grading-area

# Step 4
 javac -cp "grading-area/lib/junit-4.13.2.jar;grading-area/lib/hamcrest-2.2.jar" grading-area/*.java
if [[ $? -ne 0 ]]
then
    echo "Error: compilation failed"
    echo "Compilation output:"
    cat compilation-output.txt
    exit 1
fi

# Step 5
java -cp "grading-area\lib\junit-4.13.2.jar;grading-area\lib\hamcrest-2.2.jar" org.junit.runner.JUnitCore grading-area/TestListExamples
if grep -q "Test Failed" TestListExamples.java
then
    echo "Tests Failed"
else
    echo "Tests Passed"
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
