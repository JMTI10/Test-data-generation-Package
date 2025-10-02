Class TestData.PatientGeneratorTest
{

ClassMethod Run()
{
    Write !,"--- PatientDataGenerator Tests ---",!

    Set json = ##class(DataGeneration.PatientDataGenerator).Generate()
    Set obj = {}.%FromJSON(json)

    // make sure core fields exist
    Do ..Assert(obj.%IsDefined("id"),"has id")
    Do ..Assert(obj.%IsDefined("firstName"),"has firstName")
    Do ..Assert(obj.%IsDefined("lastName"),"has lastName")
    Do ..Assert(obj.%IsDefined("dob"),"has date of birth")

    // gender check
    Do ..Assert((obj.gender="male")!(obj.gender="female"),"gender ok")

    // email sanity
    Do ..Assert($Find(obj.email,"@")>0,"email has @")

    Write !,"PatientDataGenerator Tests done",!
}

ClassMethod Assert(cond As %Boolean, msg As %String)
{
    If cond {
        Write "PASS: ",msg,!
    } Else {
        Write "FAIL: ",msg,!
    }
}

}
