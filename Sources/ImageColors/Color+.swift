//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/10/08.
//

#if canImport(UIKit)
import UIKit
public typealias ColorType = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias ColorType = NSColor
#endif

extension ColorType {
    func clamped(minimumSaturation: Double) -> ColorType {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if saturation < minimumSaturation {
            return ColorType(hue: hue, saturation: minimumSaturation, brightness: brightness, alpha: alpha)
        } else {
            return self
        }
    }
    
    func isDistinct(color: ColorType, threshold: Double = 0.25) -> Bool {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        var rc: CGFloat = 0
        var gc: CGFloat = 0
        var bc: CGFloat = 0
        var ac: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        color.getRed(&rc, green: &gc, blue: &bc, alpha: &ac)
        
        if (fabs(r - rc) > threshold || fabs(g - gc) > threshold || fabs(b - bc) > threshold || fabs(a - ac) > threshold) {
            if (abs(r - g) < 0.03 && abs(r - b) < 0.03) {
                if (abs(rc - gc) < 0.03 && (abs(rc - bc) < 0.03)) {
                    return false
                }
            }
            return true
        }
        return false
    }
}

extension ColorType {
    var hsbValue: Int {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        let hueInteger = Int(hue * 360)
        let saturationInteger = Int(saturation * 100)
        let brightnessInteger = Int(brightness * 100)
        let valueString = String(
            format: "%03d%03d%03d",
            hueInteger,
            saturationInteger,
            brightnessInteger
        )
        return Int(valueString)!
    }
}

extension Sequence where Element == ColorType {
    public func sortedByHSB() -> [Element] {
        sorted(by: \.hsbValue)
    }
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { a, b in
            a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}
