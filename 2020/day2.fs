module Advent2020.Day2

open System
open System.Text.RegularExpressions

type PasswordMetadata =
    { Min: int32
      Max: int32
      KeyCharacter: string
      Password: string }

let parseRegex = Regex("(\\d+)-(\\d+) (\\w): (.*)")

let parsePassword (input: string): PasswordMetadata =
    let groups = parseRegex.Match(input).Groups
    { Min = int groups.[1].Value
      Max = int groups.[2].Value
      KeyCharacter = groups.[3].Value
      Password = groups.[4].Value }

let readLines = System.IO.File.ReadAllLines

let readPasswords filename =
    readLines filename
    |> Seq.map parsePassword
    |> Seq.toArray

let meetsCriteria1 (pw: PasswordMetadata) =
    let keyCharacterCount =
        Regex(pw.KeyCharacter).Matches(pw.Password).Count

    keyCharacterCount
    >= pw.Min
    && keyCharacterCount <= pw.Max

let meetsCriteria2 (pw: PasswordMetadata) =
    ((pw.Password.[pw.Min - 1]).ToString() = pw.KeyCharacter)
    <> ((pw.Password.[pw.Max - 1]).ToString() = pw.KeyCharacter)

[<EntryPoint>]
let main argv =
    let passwords = argv.[0] |> readPasswords
    passwords
    |> Seq.filter meetsCriteria1
    |> Seq.length
    |> printf "Critera1: %i\n"
    passwords
    |> Seq.filter meetsCriteria2
    |> Seq.length
    |> printf "Critera2: %i\n"
    0 // return an integer exit code
