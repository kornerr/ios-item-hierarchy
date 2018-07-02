
import UIKit

private func PRODUCTS_VIEW_LOG(_ message: String)
{
    NSLog("ProductsView \(message)")
}

class ProductsView:
    UIView,
    UICollectionViewDataSource
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupCollectionView()
    }

    var items = [String]()

    /*

     TODO PROVIDE REAL items

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
    }
    */
    
    // MARK: - COLLECTION VIEW

    @IBOutlet private var collectionView: UICollectionView!

    private func setupCollectionView()
    {
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: CellId)
        self.collectionView.dataSource = self
        
        /*
        TODO Use Pinterest-like layout
        
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
        */
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
    private typealias CellView = ProductsItemView
    private typealias Cell = UICollectionViewCellTemplate<CellView>

    private func cell(forItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell =
            self.collectionView.dequeueReusableCell(
                withReuseIdentifier: CellId,
                for: indexPath
            )
            as! Cell
        /*

        TODO

        let item = self.items[indexPath.row]
        cell.itemView.image = item.image
        cell.itemView.title = item.title.uppercased()
        */
        return cell
    }

    @IBOutlet private var titleLabel: UILabel?

    /*
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
    */


}

