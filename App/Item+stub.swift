
// Source of stub items.

// NOTE We use MassEffect races as images: http://masseffect.wikia.com/wiki/Races
// NOTE Races correcspond to <ProjectDir>/Images/race.<Race>.png images.
private let races = [
   "Asari",
   "Drell",
   "Elcor",
   "Hanar",
   "Humans",
   "Keepers",
   "Salarians",
   "Turians",
   "Volus",
]

func stubItemImage(_ title: String) -> UIImage?
{
    let race = title.lowercased()
    let imageName = "race.\(race).png"
    return UIImage(named: imageName)
}

func stubItemTitles() -> [String]
{
    return races
}

func stubItems(
    placeholderImage image: UIImage? = nil,
    randomlyTinted: Bool = false,
    titlePrefix: String? = nil
) -> [Item] {
    return
        races.map {
            var img = image ?? stubItemImage($0)
            img = randomlyTintedImage(img, randomlyTinted)
            return Item(prefixedTitle($0, titlePrefix), img)
        }
}

private func prefixedTitle(_ title: String, _ prefix: String? = nil) -> String
{
    if let prefix = prefix
    {
        return prefix + title
    }
    return title
}

private func randomlyTintedImage(
    _ image: UIImage?,
    _ randomlyTint: Bool
) -> UIImage? {
    // Do nothing if not requested.
    if !randomlyTint
    {
        return image
    }
    // Do nothing if image does not exist.
    guard let image = image else { return nil }

    // Generate random color.
    let red = CGFloat(arc4random_uniform(256)) / 256.0
    let green = CGFloat(arc4random_uniform(256)) / 256.0
    let blue = CGFloat(arc4random_uniform(256)) / 256.0
    let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    // Tint original image.
    let img = image.withRenderingMode(.alwaysTemplate)
    let gradient = [color.cgColor, color.cgColor]
	return img.tintedWithLinearGradientColors(colorsArr: gradient)
}

