import CoreGraphics
import Foundation

extension CGContext {
    public func colors(maxCount: Int = 5, minimumSaturation: Double = 0.15) -> [ColorType] {
        let imageColors = NSCountedSet(capacity: width * height)
        var offset: Int = 0
        while offset < bytesPerRow * height {
            let pixel = data!.load(fromByteOffset: offset, as: Pixel.self)
            
            let color = ColorType(
                red: Double(pixel.r) / 255.0,
                green: Double(pixel.g) / 255.0,
                blue: Double(pixel.b) / 255.0,
                alpha: Double(pixel.a) / 255.0
            )
            imageColors.add(color)
            offset += 4
        }
        class CountedColor {
            internal init(color: ColorType, count: Int) {
                self.color = color
                self.count = count
            }
            
            let color: ColorType
            let count: Int
        }
        var sortedColors: [CountedColor] = []
        let enumerator = imageColors.objectEnumerator()
        while let object = enumerator.nextObject(), let color = object as? ColorType {
            let clampedColor = color.clamped(minimumSaturation: minimumSaturation)
            let count = imageColors.count(for: color)
            sortedColors.append(CountedColor(color: clampedColor, count: count))
        }
        sortedColors.sort(by: { $0.count < $1.count })
        
        var resultColors: [ColorType] = []
        for countedColor in sortedColors {
            let currentColor = countedColor.color
            var isAlreadyAddedSimilarColor: Bool = false
            for otherColor in resultColors {
                if !currentColor.isDistinct(color: otherColor) {
                    isAlreadyAddedSimilarColor = true
                    break
                }
            }
            guard !isAlreadyAddedSimilarColor else { continue }
            guard resultColors.count < maxCount else { break }
            resultColors.append(currentColor)
        }
        
        var finalColors = resultColors
        while finalColors.count < maxCount {
            finalColors.append(.white)
        }
        return finalColors
    }
}

