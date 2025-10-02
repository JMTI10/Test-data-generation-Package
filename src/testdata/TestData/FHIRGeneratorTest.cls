Class TestData.FHIRGeneratorTest
{

ClassMethod Run()
{
    Write !,"--- FHIRGenerator Tests ---",!

    Set json = ##class(DataGeneration.FHIRGenerator).Generate()
    Set obj = {}.%FromJSON(json)

    // check resource type
    Do ..Assert(obj.resourceType="Patient","resourceType = Patient")

    // must have a name
    Do ..Assert(obj.%IsDefined("name") && obj.name.%Size()>0,"has a name")

    // birthDate should be YYYY-MM-DD
    Set ok = $Match(obj.birthDate,"^\d{4}-\d{2}-\d{2}$")
    Do ..Assert(ok,"birthDate format looks ok")

    // make sure there's a phone
    Set hasPhone=0
    For i=0:1:(obj.telecom.%Size()-1) {
        If obj.telecom.%Get(i).system="phone" {
            Set hasPhone=1
            Quit
        }
    }
    Do ..Assert(hasPhone,"telecom includes a phone")

    Write !,"FHIRGenerator Tests done",!
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
