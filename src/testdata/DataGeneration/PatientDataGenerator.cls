Class DataGeneration.PatientDataGenerator Extends %RegisteredObject
{

ClassMethod Generate() As %String
{
    Set patient = {}
    Set patient.id = $SYSTEM.Util.CreateGUID()
    Set patient.firstName = ##class(%Library.PopulateUtils).FirstName()
    Set patient.lastName = ##class(%Library.PopulateUtils).LastName()
    Set patient.dob = $ZDATE($H-($Random(30000)+5000),8)
    Set patient.gender = $Select($Random(2):"male",1:"female")

    // phone
    Set prefixes = "40,41,44,45,50"
    Set pref = $Piece(prefixes,",",$Random($Length(prefixes,",")+1))
    Set patient.phone = "+358 " _ pref _ " " _ ($Random(900)+100) _ " " _ ($Random(9000)+1000)

    // basic email
    Set patient.email = patient.firstName_"."_patient.lastName_"@example.com"

    // address
    Set addr = {}
    Set cities = "Helsinki,Tampere,Turku,Oulu,Espoo,Vantaa,Kuopio,Lahti,Jyvaskyla,Joensuu"
    Set addr.city = $Piece(cities,",",$Random($Length(cities,",")+1))
    Set addr.zip = $Random(90000)+10000
    Set addr.country = "FI"

    Do patient.%Set("address",addr)

    Quit patient.%ToJSON()
}

}
