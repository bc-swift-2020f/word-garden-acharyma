import PlaygroundSupport

var myName = "Gallagher"
var smallerString = "laugh"

//contains
if myName.contains(smallerString){
    print("\(myName) contains \(smallerString)")
}
else{
    print("There is no \(smallerString) in \(myName)")
}

// hasPrefix + hasSuffix

var occupation = "Swift Developer"
var searchString = "Swift"


print(occupation.hasPrefix(searchString))

if occupation.hasPrefix(searchString){
    print("You're hired!")
}
else{
    print("No job for you")
}

occupation = "iOS Developer"
searchString = "Developer"

if occupation.hasSuffix(searchString){
    print("Hired")
}
else{
    print("Sike")
}


print("\nremove")
var bandName = "The White Stripes"
let lastChar = bandName.removeLast()
print(lastChar)
print(bandName)

//similar removeFirst with ints too

//replacingOccurances(of: with:)
var address = "123 James St."
var streetString = "St."
var replacementString = "Street"

var standardAddress = address.replacingOccurrences(of: streetString, with: replacementString)
print(standardAddress)
print(address)


//iterate
var name = "Manogya"
var backwardsName = ""

for letter in name{
    backwardsName = String(letter) + backwardsName
}
print(backwardsName)

//capitalization
var crazyCaps = "SwIFt DeVEloPEr"
var uppercased = crazyCaps.uppercased()
var lowercased = crazyCaps.lowercased()
var capitalized = crazyCaps.capitalized

print("\(uppercased) and \(lowercased) and \(capitalized)")

var wordToGuess = "STARWARS"
var revealedWord = "_"

for _ in 1...wordToGuess.count - 1{
    revealedWord = revealedWord + " _"
}
print ("\(wordToGuess) will show as '\(revealedWord)'")

//create string from repeating value
revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
print("repeating string: '\(revealedWord)'")

revealedWord = ""
let lettersGuessed = "SQFTXW"
for letter in wordToGuess{
    if lettersGuessed.contains(letter){
        revealedWord = revealedWord + "\(letter) "
    }
    else{
        revealedWord = revealedWord + "_ "
    }
}
print("Word to Guess: \(wordToGuess)")
print("Letters Guessed: \(lettersGuessed)")
print("Revealed: \(revealedWord)")
