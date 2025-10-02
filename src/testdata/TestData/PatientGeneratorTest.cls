Class TestData.PatientGeneratorTest
{

ClassMethod Run()
{
    Write !,"--- PatientDataGenerator Tests ---",!

    Set json = ##class(DataGeneration.PatientDataGenerator).Generate()
    Set obj = {}.%FromJSON(json)

    // Test 1
    Do ..Assert(obj.%IsDefined("id"), "Patient must have an id")
    Do ..Assert(obj.%IsDefined("firstName"), "Patient must have firstName")
    Do ..Assert(obj.%IsDefined("lastName"), "Patient must have lastName")
    Do ..Assert(obj.%IsDefined("dob"), "Patient must have date of birth")

    // Test 2
    Do ..Assert((obj.gender="male")!(obj.gender="female"), "Gender must be 'male' or 'female'")

    // Test
    Do ..Assert($Find(obj.email,"@")>0, "Email must contain @")


    Write !,"PatientDataGenerator Tests Complete",!
}

/// Simple assertion helper
ClassMethod Assert(cond As %Boolean, msg As %String)
{
    If cond {
        Write "PASS: ",msg,!
    } Else {
        Write "FAIL: ",msg,!
    }
}

}
