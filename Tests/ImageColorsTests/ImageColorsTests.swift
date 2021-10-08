import XCTest
@testable import ImageColors

final class ImageColorsTests: XCTestCase {
    func testExample() throws {
        let context = CGContext(data: nil, width: 16, height: 16, bitsPerComponent: 8, bytesPerRow: 16 * 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        context.setFillColor(ColorType.red.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 2, height: 1))
        let colors = context.colors()
        XCTAssertEqual(colors[0], .red)
    }
}
