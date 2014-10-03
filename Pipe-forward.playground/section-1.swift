// Playground - noun: a place where people can play

import UIKit

infix operator |>  { precedence 50 associativity left }
public func |> <T,U>(lhs: T, rhs: T -> U) -> U {
    return rhs(lhs)
}

// func filter<S : SequenceType>(source: S, includeElement: (S.Generator.Element) -> Bool) -> [S.Generator.Element]
public func filteredWithPredicate<S : SequenceType>
    (includeElement: (S.Generator.Element) -> Bool)
    (source: S)
    -> [S.Generator.Element]
{
    return filter(source, includeElement)
}

// Curried adapter function for Swift Standard Library's sorted() function
public func sortedByPredicate<S : SequenceType>
    (predicate: (S.Generator.Element, S.Generator.Element) -> Bool)
    (source: S)
    -> [S.Generator.Element]
{
    return sorted(source, predicate)
}

// Curried adapter function for Swift Standard Library's map() function
public func mappedWithTransform<S: SequenceType, T>
    (transform: (S.Generator.Element) -> T)
    (source: S)
    -> [T]
{
    return map(source, transform)
}

let numbers = [67, 83, 4, 99, 22, 18, 21, 24, 23, 2, 86]
//let filteredNumbers = filter(numbers)
//    { $0 % 2 == 0 }
//let sortedNumbers = sorted(filteredNumbers)
//    { $1 < $0 }
//let numbersAsStrings = map(sortedNumbers)
//    { (n: Int) -> String in n.description }
//let commaSeparatedResult = ", ".join(numbersAsStrings)
//

let newSwquence =
numbers |> filteredWithPredicate { $0 % 2 == 0 }
        |> sortedByPredicate { $1 < $0 }
        |> mappedWithTransform { (n: Int) -> String in n.description }
        |> String.join(", ")


struct Point {
    var x: Int, y: Int
}

let makePoint = { (x: Int, y: Int) in Point(x: x, y: y) }

func functionCreate<T, U>(first: T, second: U) -> (T, U)
{
    return (first, second);
}

func goJony<T, U>(curry: (T, U) -> (Point), tupple: (T, U)) -> Point {
    return curry(tupple)
}

var tup = functionCreate(3, 4)

goJony(makePoint, tup)

infix operator <*> { precedence 50 associativity right }
public func <*> <T,U>(lhs: T, rhs: U) -> (T, U) {
    return (lhs, rhs)
}

public func <*> <T,U,X>(lhs: (T, U) -> (X), rhs: (T,U)) -> X {
    return lhs(rhs)
}

makePoint <*> 5
          <*> 4

struct Point3D {
    var x: Int, y: Int, z: Int
}


// --------
extension CGFloat: IntegerLiteralConvertible {
    public static func convertFromIntegerLiteral(value: IntegerLiteralType) -> CGFloat {
        return CGFloat(value)
    }
}


extension Int {
    func cast() -> CGFloat {
        return CGFloat(self)
    }
}

var make3DPoint = { (a: Int, b: (Int, Int)) in
    Point3D(x: a, y: b.0, z: b.1) }

let newPoint =
    make3DPoint <*> 5
                <*> 6
                <*> 7


struct Point4D {
    var x: Int, y: Int, z: Int, m: Int
}

var make4DPoint = { (a: Int, b: (Int, (Int, Int))) in
Point4D(x: a, y: b.0, z: b.1.0, m: b.1.1)
}

let new4DPoint = make4DPoint
    <*> 1
    <*> 2
    <*> 3
    <*> 4


func fPow(a: Double)(b: Double) -> Double {
    return pow(a, b)
}

fPow(2)(b: 3) // 8.0
let powOfFive = fPow(5) // (Function)
powOfFive(b: 3) // 125.0

