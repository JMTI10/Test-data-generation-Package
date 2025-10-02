Class TestData.RunAll
{

ClassMethod Run()
{
    Write !,"=== Running All Tests ===",!

    Do ##class(TestData.PatientGeneratorTest).Run()
    Do ##class(TestData.FHIRGeneratorTest).Run()
    Do ##class(TestData.HL7GeneratorTest).Run()

    Write !,"=== All Tests Finished ===",!
}

}
