
private func PRODUCTS_CONTROLLER_LOG(_ message: String)
{
    NSLog("ProductsController \(message)")
}

class ProductsController
{

    init() { }

    // MARK: - PLACEHOLDER ITEM IMAGE

    var placeholderItemImage: UIImage?

    // MARK: - ITEMS

    var items = [Item]()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loadItems()
            self.refreshIsExecuting = false
            self.loadImages()
        }
    }

    // MARK: - STUBS

    private func loadItems()
    {
        // Create products with placeholder image.
        self.items = stubItems(placeholderImage: self.placeholderItemImage)
        // Report the change.
        self.reportItemsChanged()
    }

    private var loadedItems = [Item]()

    private func loadImages()
    {
        // Prepare sections with "loaded" images.
        self.loadedItems = stubItems()
        // Start loading.
        self.loadNextImage()
    }

    private func loadNextImage()
    {
        // Make sure we have images to load.
        guard !self.loadedItems.isEmpty else { return }

        // "Load" image with a delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let loadedItem = self.loadedItems.remove(at: 0)
            for id in 0..<self.items.count
            {
                if self.items[id].title == loadedItem.title
                {
                    // Update image.
                    self.items[id].image = loadedItem.image

                    self.reportItemsChanged()
                    break
                }
            }

            self.loadNextImage()
        }
    }

}

