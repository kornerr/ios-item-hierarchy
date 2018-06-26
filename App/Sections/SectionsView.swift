
import UIKit

private func SECTIONS_VIEW_LOG(_ message: String)
{
    NSLog("SectionsView \(message)")
}

class SectionsView:
    UIView,
    UICollectionViewDataSource
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupCollectionView()
        self.setupItemSelection()
        self.updateTitle()
    }

    // MARK: - ITEMS

    var items: [SectionsItem]
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
    private var _items = [SectionsItem]()

    private func updateItems()
    {
        // Display items.
        self.collectionView.reloadData()

        self.updateTitle()
    }
    
    // MARK: - COLLECTION VIEW

    @IBOutlet private var collectionView: UICollectionView!
    private var collectionViewLayout: CCoverflowCollectionViewLayout?

    private func setupCollectionView()
    {
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: CellId)
        self.collectionView.dataSource = self
        
        self.collectionViewLayout = CCoverflowCollectionViewLayout()
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
    private typealias CellView = SectionsItemView
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
        return cell
    }

    // MARK: - TITLE
    
    @IBOutlet private var titleLabel: UILabel?

    private func updateTitle()
    {
        let title =
            self.items.count > self.selectedItemId ?
            self.items[self.selectedItemId].title :
            NSLocalizedString("SectionsView.Title.Undefined", comment: "")
        self.titleLabel?.text = title.uppercased()
    }

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

            SECTIONS_VIEW_LOG("Current index: '\(this.selectedItemId)'")

            this.updateTitle()
            // Report selection.
            if let report = this.selectedItemChanged
            {
                report()
            }
        }
    }


}

