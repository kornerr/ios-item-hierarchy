
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

    var itemsRoot = CategoriesItem("root")
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
            self.setupSectionsWithPlaceholderImages()
            self.refreshIsExecuting = false

            self.loadSectionImages()
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

    private func setupSectionsWithPlaceholderImages()
    {
        // Use placeholder image before real ones are available.
        self.itemsRoot.children = self.races.map { return CategoriesItem($0, self.placeholderItemImage) }
        self.reportItemsChanged()
    }

    private var loadedItemsRoot = CategoriesItem("root")

    private func loadSectionImages()
    {
        // NOTE Use MassEffect races as images: http://masseffect.wikia.com/wiki/Races
        self.loadedItemsRoot.children =
            self.races.map {
                let race = $0.lowercased()
                let imageName = "race.\(race).png"
                let image = UIImage(named: imageName)!
                return CategoriesItem($0, image)
            }
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
                    self.itemsRoot.children[id].image = loadedItem.image
                    self.reportItemsChanged()
                    break
                }
            }

            self.loadNextSectionImage()
        }
    }

}

