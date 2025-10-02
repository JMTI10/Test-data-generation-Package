Class DataGeneration.FHIRGenerator
{

/// Generate a FHIR Patient resource
ClassMethod Generate() As %String
{
    Set fhir = {}
    Set fhir.resourceType = "Patient"
    Set fhir.id = $SYSTEM.Util.CreateGUID()

    // Name
    Set nameArr = []
    Set nameObj = {}
    Set nameObj.use = "official"
    Set nameObj.family = ##class(%Library.PopulateUtils).LastName()
    Set nameObj.given = []
    Do nameObj.given.%Push(##class(%Library.PopulateUtils).FirstName())
    Do nameArr.%Push(nameObj)
    Do fhir.%Set("name", nameArr)

    // Gender & DOB
    Set fhir.gender = $Select($Random(2):"male", 1:"female")


    Set randDays = $Random(30000)+5000
    Set pastDate = $H - randDays
    Set rawDate = $ZDATE(pastDate,8)
    Set dob = $E(rawDate,1,4)_"-"_$E(rawDate,5,6)_"-"_$E(rawDate,7,8)
    Set fhir.birthDate = dob


    // Telecom
    Set telecomArr = []
    Do telecomArr.%Push({"system":"phone","value":"(555)-555-1234","use":"home"})
    Do telecomArr.%Push({"system":"email","value":"test@example.com","use":"home"})
    Do fhir.%Set("telecom", telecomArr)

    // Address
    Set addr.city  = ##class(%Library.PopulateUtils).City()
    Set addr.state = ##class(%Library.PopulateUtils).StateAbbrev()
    Set addr.postalCode = $Random(89999)+10000

    // Random US state abbreviation
    Set cities = "Helsinki,Tampere,Turku,Oulu,Espoo,Vantaa,Kuopio,Lahti,Jyväskylä,Joensuu"
    Set addr.city = $Piece(cities,",",$Random($Length(cities,",")+1))
    Set addr.country = "FI"
    Set addr.postalCode = $Random(89999)+10000

    Set addr.postalCode = $Random(90000) + 10000

    Do addrArr.%Push(addr)
    Do fhir.%Set("address", addrArr)

    Quit fhir.%ToJSON()
}

}
