module Advent2020.Day1

open System

let readLines = System.IO.File.ReadAllLines

let readNumbers filename =
    readLines filename |> Seq.map int |> Seq.toArray

let sum = List.fold (+) 0
let product = List.fold (*) 1


let pairs numbers =
    seq {
        for el1 in 1 .. ((Array.length numbers) - 1) do
            for el2 in 0 .. (el1 - 1) -> [ numbers.[el1]; numbers.[el2] ]
    }

let triples numbers =
    seq {
        for el1 in 2 .. ((Array.length numbers) - 1) do
            for el2 in 1 .. (el1 - 1) do
                for el3 in 0 .. (el2 - 1) ->
                    [ numbers.[el1]
                      numbers.[el2]
                      numbers.[el3] ]
    }

let matchTarget target = Seq.filter (fun x -> (sum x) = target)

[<EntryPoint>]
let main argv =
    let numbers = argv.[0] |> readNumbers
    numbers
    |> pairs
    |> matchTarget 2020
    |> Seq.map product
    |> printf "pairs: %A\n"
    numbers
    |> triples
    |> matchTarget 2020
    |> Seq.map product
    |> printf "triples: %A\n"
    0 // return an integer exit code
