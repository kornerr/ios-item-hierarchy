
private func CATEGORIES_CONTROLLER_LOG(_ message: String)
{
    NSLog("CateogiresController \(message)")
}

class CategoriesController
{

    init()
    {
    }

    // MARK: - PLACEHOLDER ITEM IMAGE

    var placeholderItemImage: UIImage?

    // MARK: - ITEMS

    var items = [CategoriesItem]()
    var itemsChanged: SimpleCallback?

    private func reportItemsChanged()
    {
        if let report = self.itemsChanged
        {
            report()
        }
    }

    // MARK: - ITEMS' REFRESH

    private(set) var refreshItemsIsExecuting: Bool
    {
        get
        {
            return _refreshItemsIsExecuting
        }
        set
        {
            _refreshItemsIsExecuting = newValue
            // Report the change.
            if let report = self.refreshItemsExecutionChanged
            {
                report()
            }
        }
    }
    private var _refreshItemsIsExecuting = false

    var refreshItemsExecutionChanged: SimpleCallback?

    func refreshItems()
    {
        // Skip refreshing if we're already doing it.
        guard !self.refreshItemsIsExecuting else { return }

        // Fake loading.
        self.refreshItemsIsExecuting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.setupItemsWithPlaceholderImages()
            self.refreshItemsIsExecuting = false

            self.loadMissingItemImages()
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

    private func setupItemsWithPlaceholderImages()
    {
        // Use placeholder image before real ones are available.
        self.items = self.races.map { return CategoriesItem($0, self.placeholderItemImage) }
        self.reportItemsChanged()
    }

    private var completelyLoadedItems = [CategoriesItem]()

    private func loadMissingItemImages()
    {
        // NOTE Use MassEffect races as images: http://masseffect.wikia.com/wiki/Races
        self.completelyLoadedItems =
            self.races.map {
                let race = $0.lowercased()
                let imageName = "race.\(race).png"
                let image = UIImage(named: imageName)!
                return CategoriesItem($0, image)
            }
        self.loadNextImage()
    }

    private func loadNextImage()
    {
        // Make sure we have images to load.
        guard !self.completelyLoadedItems.isEmpty else { return }

        // "Load" the first image from the array.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let loadedItem = self.completelyLoadedItems.remove(at: 0)
            for id in 0..<self.items.count
            {
                if self.items[id].title == loadedItem.title
                {
                    self.items[id].image = loadedItem.image
                    self.reportItemsChanged()
                    break
                }
            }

            self.loadNextImage()
        }
    }

}

