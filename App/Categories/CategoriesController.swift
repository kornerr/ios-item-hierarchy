
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

    var sections = [CategoriesItem]()
    var sectionsChanged: SimpleCallback?

    private func reportSectionsChanged()
    {
        if let report = self.sectionsChanged
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

            self.loadImagesForSections()
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
        self.sections = self.races.map { return CategoriesItem($0, self.placeholderItemImage) }
        self.reportSectionsChanged()
    }

    private var completelyLoadedItems = [CategoriesItem]()

    private func loadImagesForSections()
    {
        // NOTE Use MassEffect races as images: http://masseffect.wikia.com/wiki/Races
        self.completelyLoadedItems =
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
        guard !self.completelyLoadedItems.isEmpty else { return }

        // "Load" the first image from the array.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let loadedItem = self.completelyLoadedItems.remove(at: 0)
            for id in 0..<self.sections.count
            {
                if self.sections[id].title == loadedItem.title
                {
                    self.sections[id].image = loadedItem.image
                    self.reportSectionsChanged()
                    break
                }
            }

            self.loadNextSectionImage()
        }
    }

}

