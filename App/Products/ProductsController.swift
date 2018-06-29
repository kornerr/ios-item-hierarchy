
private func PRODUCTS_CONTROLLER_LOG(_ message: String)
{
    NSLog("ProductsController \(message)")
}

class ProductsController
{

    init()
    {
    }

    // MARK: - PLACEHOLDER ITEM IMAGE

    var placeholderItemImage: UIImage?

    // MARK: - ITEMS

    var items = [Item]()]()
    var itemsChanged: SimpleCallback?

    private func reportItemsChanged()
    {
        if let report = self.itemsChanged
        {
            report()
        }
    }

    // MARK: - REFRESH

    private(set) var refreshIsExecuting: Bool
    {
        get
        {
            return _refreshIsExecuting
        }
        set
        {
            _refreshIsExecuting = newValue
            // Report the change.
            if let report = self.refreshExecutionChanged
            {
                report()
            }
        }
    }
    private var _refreshIsExecuting = false

    var refreshExecutionChanged: SimpleCallback?

    func refresh()
    {
        // Skip refreshing if we're already doing it.
        guard !self.refreshIsExecuting else { return }

        // Fake loading.
        self.refreshIsExecuting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadItems()
            self.refreshIsExecuting = false

            //self.loadImages()
        }
    }

    // MARK: - STUBS

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

    private func loadItems()
    {
        // Create products with placeholder image.
        let categories = self.races.map { return CategoriesItem($0, self.placeholderItemImage) }
        var sections = [CategoriesItem]()
        for race in self.races
        {
            var section = CategoriesItem(race, self.placeholderItemImage)
            section.children = categories
            sections.append(section)
        }
        self.itemsRoot.children = sections
        // Report the change.
        self.reportItemsChanged()
    }

    private var loadedItemsRoot = CategoriesItem("root")

    private func loadedSections(tintedColor: UIColor? = nil) -> [CategoriesItem]
    {
        return self.races.map {
            let race = $0.lowercased()
            let imageName = "race.\(race).png"
            var image = UIImage(named: imageName)!
            if let color = tintedColor
            {
                image = image.withRenderingMode(.alwaysTemplate)
	            image = image.tintedWithLinearGradientColors(colorsArr: [color.cgColor, color.cgColor])
            }
            return CategoriesItem($0, image)
        }
    }

    private func loadedCategories() -> [CategoriesItem]
    {
        // Tint images with randomly generated tint color.
        let red = CGFloat(arc4random_uniform(256)) / 256.0
        let green = CGFloat(arc4random_uniform(256)) / 256.0
        let blue = CGFloat(arc4random_uniform(256)) / 256.0
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return self.loadedSections(tintedColor: color)
    }

    private func loadSectionImages()
    {
        self.loadedItemsRoot.children = self.loadedSections()
        self.loadNextSectionImage()
    }

    private func loadNextSectionImage()
    {
        // Make sure we have images to load.
        guard !self.loadedItemsRoot.children.isEmpty else { return }

        // "Load" the first image from the array.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let loadedItem = self.loadedItemsRoot.children.remove(at: 0)
            for id in 0..<self.itemsRoot.children.count
            {
                if self.itemsRoot.children[id].title == loadedItem.title
                {
                    // Update section image.
                    self.itemsRoot.children[id].image = loadedItem.image
                    // Update section categories' images
                    self.itemsRoot.children[id].children =
                        self.loadedCategories()

                    self.reportItemsChanged()
                    break
                }
            }

            self.loadNextSectionImage()
        }
    }

}

