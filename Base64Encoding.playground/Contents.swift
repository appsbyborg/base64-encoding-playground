import UIKit

// the purpose of this is to find out how much of something we can encode into a string, where we have a limit on the string's length, and want to use native base-64 encoding
// the motivation behind this is trying to encode arbitrary data into Message's MSMessage.url property, while only using native frameworks and language features

func decodeBase64String<T>(input:String) -> [T] {
    guard let inputData = Data.init(base64Encoded: input) else {
        print("Bad Data! 👹")
        return [T]()
    }

    let dataLength = inputData.count/MemoryLayout<T>.stride
    let points:[T] = inputData.withUnsafeBytes { (pointer:UnsafePointer<T>) -> [T] in
        var output = [T]()
        for i in 0..<dataLength {
            output.append(pointer.advanced(by: i).pointee)
        }
        return output
    }
    return points
}

var sampleData:[CGPoint] = [CGPoint]()

var encodedStr:String = ""
let UPPER_COMPUTING_BOUND = 5000 //just a safety measure
let MAX_STRING_LENGTH = 4997 //

print("Checking how much data can be held in a base-64 encoded string of max length \(MAX_STRING_LENGTH)...")

for _ in 0..<UPPER_COMPUTING_BOUND {
    
    sampleData.append(CGPoint.init(x: CGFloat.random(in: Range<CGFloat>.init(uncheckedBounds: (-1000.0, 1000.0)) ), y: CGFloat.random(in: Range<CGFloat>.init(uncheckedBounds: (-1000.0, 1000.0)))))
    
    let pathData:Data = NSData.init(bytes: sampleData, length: MemoryLayout<CGPoint>.stride*sampleData.count) as Data
    encodedStr = pathData.base64EncodedString()
    if encodedStr.count > MAX_STRING_LENGTH {
        //We've gone too far! remove last element and return
        sampleData.removeLast()
        encodedStr = (NSData.init(bytes: sampleData, length: MemoryLayout<CGPoint>.stride*sampleData.count) as Data).base64EncodedString()
        break
    }
}

print("DONE I can hold \(sampleData.count) values in a base-64 encoded string of length \(encodedStr.count)")
print("attempting to decode base-64 string...")
let decodedPoints:[CGPoint] = decodeBase64String(input: encodedStr)
print ("decoded \(decodedPoints.count) points")
//sampleData[10] = CGPoint.init(x: 69, y: 69) //to test equality in the negative
print ("Are the decoded points equal to the encoded points? \(decodedPoints == sampleData ? "Yes! 🍺" : "No 👎")")
