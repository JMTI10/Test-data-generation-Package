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
    Set nameObj.given = []   // initialize given as array
    Do nameObj.given.%Push(##class(%Library.PopulateUtils).FirstName())
    Do nameArr.%Push(nameObj)
    Do fhir.%Set("name", nameArr)

    // Gender & DOB
    Set fhir.gender = $Select($Random(2):"male", 1:"female")

      // Generate DOB in YYYY-MM-DD format
    Set randDays = $Random(30000)+5000  // between ~13 and ~82 years ago
    Set pastDate = $H - randDays
    Set rawDate = $ZDATE(pastDate,8)    // YYYYMMDD
    Set dob = $E(rawDate,1,4)_"-"_$E(rawDate,5,6)_"-"_$E(rawDate,7,8)
    Set fhir.birthDate = dob


    // Telecom
    Set telecomArr = []
    Do telecomArr.%Push({"system":"phone","value":"(555)-555-1234","use":"home"})
    Do telecomArr.%Push({"system":"email","value":"test@example.com","use":"home"})
    Do fhir.%Set("telecom", telecomArr)

    // Address
    Set addrArr = []
    Set addr = {}
    Set addr.city  = ##class(%Library.PopulateUtils).City()

    // Random US state abbreviation
    Set states="AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY"
    Set stateList=$LISTFROMSTRING(states,",")
    Set randIndex=$Random($LISTLENGTH(stateList))+1
    Set addr.state=$LISTGET(stateList,randIndex)

    Set addr.postalCode = $Random(90000) + 10000

    Do addrArr.%Push(addr)
    Do fhir.%Set("address", addrArr)

    Quit fhir.%ToJSON()
}

}
