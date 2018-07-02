
import UIKit

private func CATEGORIES_VIEW_LOG(_ message: String)
{
    NSLog("CategoriesView \(message)")
}

private let ITEM_SIZE = CGSize(width: 100, height: 130)
private let ITEM_SPACING: Float = 60
private let ITEM_SCALES: [NSNumber: NSNumber] = [
    -1.0: 0.5,
    -0.6: 0.8,
]
private let ITEM_POSITIONS: [NSNumber: NSNumber] = [
    -1.0: NSNumber(value: -ITEM_SPACING * 0.6),
    -0.6: NSNumber(value: -ITEM_SPACING * 0.4),
]

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

    var items: [Item]
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
    private var _items = [Item]()

    private func updateItems()
    {
        // Display items.
        self.collectionView.reloadData()

        // Report item selection.
        self.reportItemSelection()
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
        layout.cellSize = ITEM_SIZE
        layout.cellSpacing = CGFloat(ITEM_SPACING)
        layout.darknessInterpolator = nil
        layout.rotationInterpolator = nil
        layout.scaleInterpolator = CInterpolator(dictionary: ITEM_SCALES).withReflection(false)
        layout.positionoffsetInterpolator = CInterpolator(dictionary: ITEM_POSITIONS).withReflection(true)

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
        cell.itemView.title = item.title.uppercased()
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
            this.reportItemSelection()
        }
    }

    private func reportItemSelection()
    {
        if let report = self.selectedItemChanged
        {
            report()
        }
    }

}

