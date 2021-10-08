//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/10/08.
//

#if canImport(UIKit)
import UIKit
public typealias ImageType = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias ImageType = NSImage
#endif

extension ImageType {
    public func colors(maxCount: Int = 5, scale: Double = 1) -> [ColorType] {
        self.cgImage!.colors(maxCount: maxCount)
    }
}

extension CGImage {
    public func colors(maxCount: Int = 5, scale: Double = 1) -> [ColorType] {
        let width = Int(Double(width) * scale)
        let height = Int(Double(height) * scale)
        let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        )!
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.draw(self, in: rect)
        return context.colors(maxCount: maxCount)
    }
}
