
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
            self.setupItemsWithStubImages()
            self.refreshItemsIsExecuting = false

            // TODO Load item images one by one.
        }
    }

    // MARK: - STUBS

    private func setupItemsWithStubImages()
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
        // Report items.
        if let report = self.itemsChanged
        {
            report()
        }
    }

    /*
    private func setupSectionItems()
    {
        // Use MassEffect races as sections: http://masseffect.wikia.com/wiki/Races
        self.sectionsView.items = [
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
    }
    */


}

