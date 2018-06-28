
import UIKit

private func CATEGORIES_VIEW_LOG(_ message: String)
{
    NSLog("CategoriesView \(message)")
}

private let ITEM_SIZE = CGSize(width: 100, height: 100)
private let ITEM_SPACING: Float = 40
private let ITEM_SCALES: [NSNumber: NSNumber] = [
    -1.0: 0.8,
    -0.8: 1.0,
]
private let ITEM_POSITIONS: [NSNumber: NSNumber] = [
    -1.0: NSNumber(value: -ITEM_SPACING * 2.0),
    NSNumber(value: -0.2 - FLT_EPSILON): 0.0,
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

