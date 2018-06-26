
private func SECTIONS_CONTROLLER_LOG(_ message: String)
{
    NSLog("SectionsController \(message)")
}

class SectionsController
{

    init()
    {
    }

    // MARK: - PLACEHOLDER ITEM IMAGE

    var placeholderItemImage: UIImage?

    // MARK: - ITEMS

    var items = [SectionsItem]()
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

    private func setupItemsWithPlaceholderImages()
    {
        // Use placeholder image before real ones are available.
        let placeholder = self.placeholderItemImage
        self.items = [
            SectionsItem("Asari", placeholder),
            SectionsItem("Drell", placeholder),
            SectionsItem("Elcor", placeholder),
            SectionsItem("Hanar", placeholder),
            SectionsItem("Humans", placeholder),
            SectionsItem("Keepers", placeholder),
            SectionsItem("Salarians", placeholder),
            SectionsItem("Turians", placeholder),
            SectionsItem("Volus", placeholder),
        ]
        self.reportItemsChanged()
    }

    private var completelyLoadedItems = [SectionsItem]()

    private func loadMissingItemImages()
    {
        // NOTE We actually replace placeholder items with "loaded" ones
        // NOTE instead of loading images.
        // NOTE We use MassEffect races as images: http://masseffect.wikia.com/wiki/Races
        self.completelyLoadedItems = [
            SectionsItem(
                "Asari",
                UIImage(named: "race.asari.png")!
            ),
            SectionsItem(
                "Drell",
                UIImage(named: "race.drell.png")!
            ),
            SectionsItem(
                "Elcor",
                UIImage(named: "race.elcor.png")!
            ),
            SectionsItem(
                "Hanar",
                UIImage(named: "race.hanar.png")!
            ),
            SectionsItem(
                "Humans",
                UIImage(named: "race.humans.jpg")!
            ),
            SectionsItem(
                "Keepers",
                UIImage(named: "race.keeper.png")!
            ),
            SectionsItem(
                "Salarians",
                UIImage(named: "race.salarians.png")!
            ),
            SectionsItem(
                "Turians",
                UIImage(named: "race.turians.png")!
            ),
            SectionsItem(
                "Volus",
                UIImage(named: "race.volus.png")!
            ),
        ]
        self.loadNextItem()
    }

    private func loadNextItem()
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

            self.loadNextItem()
        }
    }

}

