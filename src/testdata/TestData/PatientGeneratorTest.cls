Class TestData.PatientGeneratorTest
{

ClassMethod Run()
{
    Write !,"--- PatientDataGenerator Tests ---",!

    Set json = ##class(DataGeneration.PatientDataGenerator).Generate()
    Set obj = {}.%FromJSON(json)

    // Test 1: Has required fields
    Do ..Assert(obj.%IsDefined("id"), "Patient must have an id")
    Do ..Assert(obj.%IsDefined("firstName"), "Patient must have firstName")
    Do ..Assert(obj.%IsDefined("lastName"), "Patient must have lastName")
    Do ..Assert(obj.%IsDefined("dob"), "Patient must have date of birth")

    // Test 2: Gender must be male or female
    Do ..Assert($Listfind("male,female", obj.gender)>0, "Gender must be 'male' or 'female'")

    // Test 3: Email must contain '@'
    Do ..Assert(obj.email [ "@", "Email must contain @")

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
