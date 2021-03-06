
private func CATEGORIES_CONTROLLER_LOG(_ message: String)
{
    NSLog("CateogiresController \(message)")
}

class CategoriesController
{

    init() { }

    // MARK: - PLACEHOLDER ITEM IMAGE

    var placeholderItemImage: UIImage?

    // MARK: - ITEMS

    var itemsRoot = Item("root")
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
            self.loadImages()
        }
    }

    // MARK: - STUBS

    private func loadItems()
    {
        // Create sections and categories with placeholder image.
        // Both sections and categories contain the same item set.
        var sections = [Item]()
        let sectionTitles = stubItemTitles()
        for title in sectionTitles
        {
            var section = Item(title, self.placeholderItemImage)
            section.children =
                stubItems(placeholderImage: self.placeholderItemImage, titlePrefix: title)
            sections.append(section)
        }
        self.itemsRoot.children = sections
        // Report the change.
        self.reportItemsChanged()
    }

    private var loadedItemsRoot = Item("root")

    private func loadImages()
    {
        // Prepare sections with "loaded" images.
        self.loadedItemsRoot.children = stubItems()
        // Start loading.
        self.loadNextImage()
    }

    private func loadNextImage()
    {
        // Make sure we have images to load.
        guard !self.loadedItemsRoot.children.isEmpty else { return }

        // "Load" image with a delay.
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
                        stubItems(randomlyTinted: true, titlePrefix: loadedItem.title)

                    self.reportItemsChanged()
                    break
                }
            }

            self.loadNextImage()
        }
    }

}

