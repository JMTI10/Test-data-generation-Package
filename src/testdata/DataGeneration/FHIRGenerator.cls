Class DataGeneration.FHIRGenerator
{

/// Generate a FHIR Patient resource
ClassMethod Generate() As %String
{
    Set fhir = {}
    Set fhir.resourceType = "Patient"
    Set fhir.id = $ZCRC($H,99999)

    // Name
    Set nameArr = []
    Set nameObj = {}
    Set nameObj.use = "official"
    Set nameObj.family = ##class(%Library.PopulateUtils).LastName()
    Do nameObj.given.%Push(##class(%Library.PopulateUtils).FirstName())
    Do nameArr.%Push(nameObj)
    Do fhir.%Set("name", nameArr)

    // Gender & DOB
    Set fhir.gender = $Select($Random(2):"male", 1:"female")
    Set fhir.birthDate = $ZDATE($H-($RANDOM(30000)+5000),8)

    // Telecom
    Set telecomArr = []
    Set tel1 = {"system":"phone","value":"(555)-555-1234","use":"home"}
    Set tel2 = {"system":"email","value":"test@example.com","use":"home"}
    Do telecomArr.%Push(tel1)
    Do telecomArr.%Push(tel2)
    Do fhir.%Set("telecom", telecomArr)

    // Address
    Set addrArr = []
    Set addr = {}
    Set addr.city  = ##class(%Library.PopulateUtils).City()
    Set addr.state = ##class(%Library.PopulateUtils).State()
    Set addr.postalCode = $Random(89999)+10000
    Do addrArr.%Push(addr)
    Do fhir.%Set("address", addrArr)

    Quit fhir.%ToJSON()
}

}
