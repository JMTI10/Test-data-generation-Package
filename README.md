This project contains three generators to create synthetic patient data in different formats:

PatientDataGenerator → Simple JSON patient record

FHIRGenerator → FHIR-compliant Patient resource (JSON)

HL7Generator → HL7 v2.x patient message (pipe-delimited text)

It also contains corresponding unit tests under src/testdata/TestData.

Prerequisites

Docker
 installed

InterSystems IRIS Community Edition
 (container image already pulled & running)

Example container run:

docker run -d --name iris \
  -v C:\path\Test-data-generation-Package:/irisdev/app \
  -p 52773:52773 -p 1972:1972 \
  intersystems/irishealth-community:2025.1

Load the Code into IRIS

Open a terminal inside IRIS:

docker exec -it <Container_name> iris session iris


Switch to the USER namespace (default):

ZN "USER"


Load the classes:
do $system.OBJ.LoadDir("/irisdev/app/src/testdata/DataGeneration","ck")

do $system.OBJ.LoadDir("/irisdev/app/src/testdata/TestData","ck")

Run the Generators
WRITE ##class(DataGeneration.PatientDataGenerator).Generate()

WRITE ##class(DataGeneration.FHIRGenerator).Generate()

WRITE ##class(DataGeneration.HL7Generator).Generate()


Each call will output a synthetic record.

Run the Tests
do ##class(TestData.PatientGeneratorTest).Run()
do ##class(TestData.FHIRGeneratorTest).Run()
do ##class(TestData.HL7GeneratorTest).Run()

Run all Generators and test
do $system.OBJ.LoadDir("/irisdev/app/src/testdata/DataGeneration","ck")
do $system.OBJ.LoadDir("/irisdev/app/src/testdata/TestData","ck")

Tests will print PASS/FAIL messages for key validations.

File Structure
/src/testdata/DataGeneration
   PatientDataGenerator.cls   → JSON patient
   FHIRGenerator.cls          → FHIR patient
   HL7Generator.cls           → HL7 message

/src/testdata/TestData
   PatientGeneratorTest.cls   → Tests for PatientDataGenerator
   FHIRGeneratorTest.cls      → Tests for FHIRGenerator
   HL7GeneratorTest.cls       → Tests for HL7Generator
