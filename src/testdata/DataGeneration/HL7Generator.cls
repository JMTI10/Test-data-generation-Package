Class TestData.HL7GeneratorTest
{

ClassMethod Run()
{
    Write !,"--- Running HL7Generator Tests ---",!

    // Generate a test HL7 message
    Set msg = ##class(DataGeneration.HL7Generator).Generate()

    // Basic checks
    Do ..Assert($Extract(msg,1,4)="MSH|", "Message begins with MSH")
    Do ..Assert(msg["PID|", "PID segment included")
    Do ..Assert(msg["2.3", "Version 2.3 present")

    // Check gender field from PID
    Set pid = $Piece(msg,"PID|",2)
    Set gender = $Piece(pid,"|",8)
    Do ..Assert($ListFind($LB("M","F"),gender)>0, "Gender is M or F")

    Write !,"HL7Generator Tests Finished",!
}

ClassMethod Assert(cond As %Boolean, msg As %String)
{
    If cond {
        Write "PASS: ", msg, !
    } Else {
        Write "FAIL: ", msg, !
    }
}

}
