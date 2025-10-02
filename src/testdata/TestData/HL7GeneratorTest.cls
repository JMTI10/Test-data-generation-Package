Class TestData.HL7GeneratorTest
{

ClassMethod Run()
{
    Write !,"--- HL7Generator Tests ---",!

    Set msg = ##class(DataGeneration.HL7Generator).Generate()

    // check message starts right
    Do ..Assert($Extract(msg,1,4)="MSH|","starts with MSH|")

    // should have a PID
    Do ..Assert(msg["PID|","has PID segment")

    // should mention HL7 version
    Do ..Assert(msg["2.3","has HL7 v2.3")

    // gender check in PID
    Set pid = $Piece(msg,"PID|",2)
    Set gender = $Piece(pid,"|",8)
    Do ..Assert($ListFind($LB("M","F"),gender)>0,"gender is M or F")

    Write !,"HL7Generator Tests done",!
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
