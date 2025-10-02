Class DataGeneration.HL7Generator
{

/// Generate a simple HL7 v2.3 ADT^A01 message
ClassMethod Generate() As %String
{
    // Unique ID
    Set id = $SYSTEM.Util.CreateGUID()

    // HL7 date/time format: YYYYMMDDHHMMSS
    Set now = $ZDATETIME($HOROLOG,14)

    // MSH segment
    Set msg = "MSH|^~\&|TestApp|TestFacility|DestApp|DestFacility|"_now_"||ADT^A01|"_id_"|P|2.3"_$C(13)

    // PID segment
    Set first  = ##class(%Library.PopulateUtils).FirstName()
    Set last   = ##class(%Library.PopulateUtils).LastName()
    Set gender = $Select($Random(2):"M", 1:"F")

    // Random DOB in DDMMYYYY format
    Set randH = $HOROLOG - ($RANDOM(30000) + 5000)
    Set dobYMD = $ZDATE(randH,8)  // YYYYMMDD
    // Reformat to DDMMYYYY
    Set dob = $E(dobYMD,7,8)_$E(dobYMD,5,6)_$E(dobYMD,1,4)

    Set pid = "PID|||"_id_"||"_last_"^"_first_"||"_dob_"|"_gender_"|||123 Fake St^^Springfield^IL^62704|||(555)555-1234|||S|"_$C(13)

    Quit msg _ pid
}

}
