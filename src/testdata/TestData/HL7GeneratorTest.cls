Class TestData.HL7GeneratorTest
{

ClassMethod Run()
{
    Write !,"--- HL7Generator Tests ---",!

    // Generate an HL7 message
    Set msg = ##class(DataGeneration.HL7Generator).Generate()

    // Test 1
    Do ..Assert($Extract(msg,1,4)="MSH|", "Message starts with MSH|")

    // Test 2
    Do ..Assert(msg["PID|", "Message contains PID segment")

    // Test 3
    Do ..Assert(msg["2.3", "HL7 version 2.3 present")

    // Test 4
    Set pid = $Piece(msg,"PID|",2)
    Set gender = $Piece(pid,"|",8)
    Do ..Assert($ListFind($LB("M","F"),gender)>0, "Gender is M or F")

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
