Class DataGeneration.FHIRGenerator
{ClassMethod Generate() As %String
    {
        Set fhir = {}
        Set fhir.resourceType = "Patient"
        Set fhir.id = $SYSTEM.Util.CreateGUID()
        Set nameArr = []
        Set nameObj = {}
        Set nameObj.use = "official"
        Set nameObj.family = ##class(%Library.PopulateUtils).LastName()
        Set nameObj.given = []
        Do nameObj.given.%Push(##class(%Library.PopulateUtils).FirstName())
        Do nameArr.%Push(nameObj)
        Do fhir.%Set("name", nameArr)
        Set fhir.gender = $Select($Random(2):"male", 1:"female")
        Set randDays = $Random(30000)+5000
        Set pastDate = $H - randDays
        Set rawDate = $ZDATE(pastDate,8)
        Set dob = $E(rawDate,1,4)_"-"_$E(rawDate,5,6)_"-"_$E(rawDate,7,8)
        Set fhir.birthDate = dob
        Set telecomArr = []
        Set phonePrefixes = "40,41,44,45,50"
        Set prefix = $Piece(phonePrefixes,",",$Random($Length(phonePrefixes,",")+1))
        Set phone = "+358 " _ prefix _ " " _ ($Random(900)+100) _ " " _ ($Random(9000)+1000)
        Set tel = {}
        Do tel.%Set("system","phone")
        Do tel.%Set("value",phone)
        Do tel.%Set("use","home")
        Do telecomArr.%Push(tel)
        Set mail = {}
        Do mail.%Set("system","email")
        Do mail.%Set("value","test@example.com")
        Do mail.%Set("use","home")
        Do telecomArr.%Push(mail)
        Do fhir.%Set("telecom", telecomArr)
        Set addrArr = []
        Set addr = {}
        Set cities = "Helsinki,Tampere,Turku,Oulu,Espoo,Vantaa,Kuopio,Lahti,Jyvaskyla,Joensuu"
        Do addr.%Set("city", $Piece(cities,",",$Random($Length(cities,",")+1)))
        Do addr.%Set("country", "FI")
        Do addr.%Set("postalCode", $Random(90000)+10000)
        Do addrArr.%Push(addr)
        Do fhir.%Set("address", addrArr)
        Quit fhir.%ToJSON()
    }

}
