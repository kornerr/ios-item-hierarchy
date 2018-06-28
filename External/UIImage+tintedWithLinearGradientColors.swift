// Topic: How can I tint a UIImage with gradient?
// Source: https://stackoverflow.com/questions/8098130/how-can-i-tint-a-uiimage-with-gradient

import UIKit

extension UIImage
{

	func tintedWithLinearGradientColors(colorsArr: [CGColor]) -> UIImage
	{
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
		guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
		context.translateBy(x: 0, y: self.size.height)
		context.scaleBy(x: 1, y: -1)

		context.setBlendMode(.normal)
		let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)

		// Create gradient
		let colors = colorsArr as CFArray
		let space = CGColorSpaceCreateDeviceRGB()
		let gradient = CGGradient(colorsSpace: space, colors: colors, locations: nil)

		// Apply gradient
		context.clip(to: rect, mask: self.cgImage!)
		context.drawLinearGradient(
            gradient!,
            start: CGPoint(x: 0, y: 0),
            end: CGPoint(x: 0, y: self.size.height),
            options: .drawsAfterEndLocation
        )
		let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return gradientImage!
	}

}
