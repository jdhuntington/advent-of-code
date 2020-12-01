open System

let readLines = System.IO.File.ReadAllLines


let readNumbers filename = readLines filename |> Seq.map int

let pairs numbers = seq {
    for el1 in numbers do
        for el2 in numbers ->
            (el1, el2)
}

let triples numbers = seq {
    for el1 in numbers do
        for el2 in numbers do
            for el3 in numbers ->
                (el1, el2, el3)
}


let sumEq pair target = 
    let (a,b) = pair
    a + b = target

let sumEqTriple triple target = 
    let (a,b,c) = triple
    a + b + c = target

let matchTarget target pairs =
    Seq.filter (fun x -> sumEq x target) pairs

let matchTargetTriple target triples =
    Seq.filter (fun x -> sumEqTriple x target) triples

let printResult pair =
    let (a,b) = pair
    printf "%A -> %A" pair (a*b)
    ()

[<EntryPoint>]
let main argv =
    argv.[0] |> readNumbers|> pairs |> matchTarget 2020 |> printf "%A"
    argv.[0] |> readNumbers|> triples |> matchTargetTriple 2020 |> printf "%A"
    0 // return an integer exit code
