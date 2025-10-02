Class TestData.FHIRGeneratorTest
{

ClassMethod Run()
{
    Write !,"--- FHIRGenerator Tests ---",!

    Set json = ##class(DataGeneration.FHIRGenerator).Generate()
    Set obj = {}.%FromJSON(json)

    // Test 1: ResourceType must be Patient
    Do ..Assert(obj.resourceType="Patient", "ResourceType is Patient")

    // Test 2: Has at least one name
    Do ..Assert(obj.%IsDefined("name") && obj.name.%Size()>0, "Has name array")

    // Test 3: BirthDate must be in YYYY-MM-DD format
    Set ok = $Match(obj.birthDate, "^\d{4}-\d{2}-\d{2}$")
    Do ..Assert(ok, "BirthDate has format YYYY-MM-DD")

    // Test 4: Telecom must include phone
    Set foundPhone=0
    For i=0:1:(obj.telecom.%Size()-1) {
        If obj.telecom.%Get(i).system="phone" {
            Set foundPhone=1
        }   
    }
    Do ..Assert(foundPhone, "Telecom includes phone")


    Write !,"FHIRGenerator Tests Complete",!
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
