Class TestData.HL7GeneratorTest
{

ClassMethod Run()
{
    Write !,"--- HL7Generator Tests ---",!

    Set hl7 = ##class(DataGeneration.HL7Generator).Generate()

    // Test 1: Must start with MSH|
    Do ..Assert($Extract(hl7,1,4)="MSH|", "Message starts with MSH|")

    // Test 2: Must contain PID segment
    Do ..Assert(hl7["PID|", "Message contains PID segment")

    // Test 3: HL7 version is 2.3
    Do ..Assert(hl7["|2.3", "HL7 version 2.3 present")

    // Test 4: Patient gender is M or F
    // We'll look at the PID segment
    Set pid = $Piece(hl7,"PID|",2)
    Set fields = $ListFromString($Piece(pid,$C(13),1),"|")
    Set gender = $ListGet(fields,9) // HL7 PID-8
    Do ..Assert($Listfind("M,F",gender)>0, "Gender is M or F")

    Write !,"HL7Generator Tests Complete",!
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
