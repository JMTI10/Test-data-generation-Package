Class MyPackage.Installer
{
ClassMethod Install()
{
    write "Installing Test Data Generator...",!
    write "Loading DataGeneration classes...",!
    do $system.OBJ.LoadDir("/irisdev/app/src/testdata/DataGeneration","ck")
    write "Loading TestData classes...",!
    do $system.OBJ.LoadDir("/irisdev/app/src/testdata/TestData","ck")
    write "✓ Installation complete!",!
    write !,"Available commands:",!
    write "  WRITE ##class(DataGeneration.PatientDataGenerator).Generate()",!
    write "  WRITE ##class(DataGeneration.FHIRGenerator).Generate()",!
    write "  WRITE ##class(DataGeneration.HL7Generator).Generate()",!
    write "  do ##class(TestData.PatientGeneratorTest).Run()",!
    write "  do ##class(TestData.FHIRGeneratorTest).Run()",!
    write "  do ##class(TestData.HL7GeneratorTest).Run()",!
}
}