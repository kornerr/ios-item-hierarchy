
import UIKit

class CBetterCollectionViewCellTemplate<ItemView: UIView>: CBetterCollectionViewCell
{

    var itemView: ItemView!

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        // Load and embed item view.
        self.itemView = ItemView.loadFromNib()
        self.contentView.embeddedView = self.itemView
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("CBetterCollectionViewCellTemplate. ERROR: init(coder:) has not been implemented")
    }

}

