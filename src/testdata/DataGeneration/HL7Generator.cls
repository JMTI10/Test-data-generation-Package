Class DataGeneration.HL7Generator
{

/// Generate a simple HL7 ADT^A01 message
ClassMethod Generate() As %String
{
    Set id     = $ZCRC($H,99999)
    Set first  = ##class(%Library.PopulateUtils).FirstName()
    Set last   = ##class(%Library.PopulateUtils).LastName()
    Set dob    = $ZDATE($H-($RANDOM(30000)+5000),3)  // YYYYMMDD
    Set gender = $Select($Random(2):"M", 1:"F")

    // HL7 message lines
    Set msg = "MSH|^~\&|SendingApp|SendingFac|ReceivingApp|ReceivingFac|"_$ZDATETIME($H,3)_"||ADT^A01|"_id_"|P|2.3"_$C(13)
    Set msg = msg_"PID|1||"_id_"^^^Hospital^MR||"_last_"^"_first_"||"_dob_"|"_gender_$C(13)

    Quit msg
}

}
