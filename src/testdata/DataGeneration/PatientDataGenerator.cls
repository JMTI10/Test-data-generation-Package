Class DataGeneration.PatientDataGenerator Extends %RegisteredObject
{

ClassMethod Generate() As %String
{
    // Create object for patient
    Set patient = {}

    // Demographics
    Set patient.id        = $SYSTEM.Util.CreateGUID()
    Set patient.firstName = ##class(%Library.PopulateUtils).FirstName()
    Set patient.lastName  = ##class(%Library.PopulateUtils).LastName()
    Set patient.dob       = $ZDATE($H-($RANDOM(30000)+5000),8)
    Set patient.gender    = $Select($Random(2):"male", 1:"female")

    // Contact info
    Set patient.phone = "(555)-"_($Random(900)+100)_"-"_($Random(9000)+1000)
    Set patient.email = patient.firstName_"."_patient.lastName_"@"_"example.com"

    // Address
    Set addr = {}
    Set addr.city  = ##class(%Library.PopulateUtils).City()
    
    // Since PopulateUtils
    Set states="CA,NY,TX,FL,MA,IL,WA,GA,NC,PA"
    Set addr.state = $Piece(states,",",$Random($Length(states,",")+1))
    
    Set addr.zip   = $Random(89999)+10000
    Do patient.%Set("address", addr)

    Quit patient.%ToJSON()
}

}
