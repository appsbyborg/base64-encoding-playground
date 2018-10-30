import UIKit

// the purpose of this is to find out how much of something we can encode into a string, where we have a limit on the string's length, and want to use native base-64 encoding
// the motivation behind this is trying to encode arbitrary data into Message's MSMessage.url property, while only using native frameworks and language features

var pathPairs:[CGPoint] = [CGPoint]()

var encodedStr:String = ""
let UPPER_COMPUTING_BOUND = 5000 //just a safety measure
let MAX_STRING_LENGTH = 4997 //

print("size \(MemoryLayout<CGPoint>.size)")

for _ in 0..<UPPER_COMPUTING_BOUND {
    
    pathPairs.append(CGPoint.init(x: CGFloat.random(in: Range<CGFloat>.init(uncheckedBounds: (-1000.0, 1000.0)) ), y: CGFloat.random(in: Range<CGFloat>.init(uncheckedBounds: (-1000.0, 1000.0)))))
    let pathData:Data = NSData.init(bytes: pathPairs, length: MemoryLayout<CGPoint>.size*pathPairs.count) as Data
    encodedStr = pathData.base64EncodedString()
    if encodedStr.count > MAX_STRING_LENGTH {
        //We've gone too far! remove last element and return
        pathPairs.removeLast()
        encodedStr = (NSData.init(bytes: pathPairs, length: MemoryLayout<CGPoint>.size*pathPairs.count) as Data).base64EncodedString()
        break
    }
}

print("DONE I can hold \(pathPairs.count) values in a base-64 encoded string of length \(encodedStr.count)")

print(encodedStr)
