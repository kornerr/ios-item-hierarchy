
import UIKit

private func PRODUCTS_VIEW_LOG(_ message: String)
{
    NSLog("ProductsView \(message)")
}

// Make sure there's ITEM_INSET space between item and screen's edge
private let ITEM_INSET: CGFloat = 10
// Constants' explanation:
// * 320 is iPhone 5/SE screen width
// * 2 = two columns per row
private let ITEM_WIDTH: CGFloat = 320 / 2 - ITEM_INSET * 2
// Make item somewhat tall.
private let ITEM_HEIGHT: CGFloat = ITEM_WIDTH * 1.2

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
    
    // MARK: - COLLECTION VIEW

    @IBOutlet private var collectionView: UICollectionView!

    private func setupCollectionView()
    {
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: CellId)
        self.collectionView.dataSource = self

        // Create and configure layout.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ITEM_WIDTH, height: ITEM_HEIGHT)
        let inset = ITEM_INSET
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        self.collectionView.collectionViewLayout = layout
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
        let item = self.items[indexPath.row]
        cell.itemView.image = item.image
        cell.itemView.title = item.title.uppercased()
        return cell
    }

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

