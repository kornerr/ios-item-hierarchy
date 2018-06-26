
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
        // Provide stub image before real one has been loaded.
        let image = UIImage(named: "blurred.logo.cerberus.jpg")!
        self.items = [
            SectionsItem("Asari", image),
            SectionsItem("Drell", image),
            SectionsItem("Elcor", image),
            SectionsItem("Hanar", image),
            SectionsItem("Humans", image),
            SectionsItem("Keepers", image),
            SectionsItem("Salarians", image),
            SectionsItem("Turians", image),
            SectionsItem("Volus", image),
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

