
import UIKit

private func CATEGORIES_VIEW_LOG(_ message: String)
{
    NSLog("CategoriesView \(message)")
}

class CategoriesView:
    UIView,
    UICollectionViewDataSource
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupCollectionView()
        self.setupItemSelection()
    }

    // MARK: - ITEMS

    var items: [CategoriesItem]
    {
        get
        {
            return _items
        }
        set
        {
            _items = newValue
            self.updateItems()
        }
    }
    private var _items = [CategoriesItem]()

    private func updateItems()
    {
        // Display items.
        self.collectionView.reloadData()
    }
    
    // MARK: - COLLECTION VIEW

    @IBOutlet private var collectionView: UICollectionView!
    private var collectionViewLayout: ConfigurableCollectionViewLayout!

    private func setupCollectionView()
    {
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: CellId)
        self.collectionView.dataSource = self
        
        // Create and configure layout.
        let layout = ConfigurableCollectionViewLayout()
        layout.darknessInterpolator = nil
        // Keep layout.
        self.collectionViewLayout = layout

        // Provide layout to collection view.
        self.collectionView.collectionViewLayout = self.collectionViewLayout!
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return self.cell(forItemAt: indexPath)
    }

    // MARK: - CELL

    private let CellId = "CellId"
    private typealias CellView = CategoriesItemView
    private typealias Cell = CBetterCollectionViewCellTemplate<CellView>

    private func cell(forItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell =
            self.collectionView.dequeueReusableCell(
                withReuseIdentifier: CellId,
                for: indexPath
            )
            as! Cell
        let item = self.items[indexPath.row]
        cell.itemView.image = item.image
        // TODO Title
        return cell
    }

    @IBOutlet private var titleLabel: UILabel?

    // MARK: - ITEM SELECTION

    var selectedItemId: Int
    {
        get
        {
            return self.collectionViewLayout?.currentIndexPath?.row ?? 0
        }
    }
    var selectedItemChanged: SimpleCallback?
    
    private func setupItemSelection()
    {
        self.collectionViewLayout?.currentIndexPathChanged = { [weak self] in
            guard let this = self else { return }

            CATEGORIES_VIEW_LOG("Selected category: '\(this.selectedItemId)'")

            // Report selection.
            if let report = this.selectedItemChanged
            {
                report()
            }
        }
    }


}

