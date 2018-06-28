
import UIKit

class CategoriesItemView: UIView
{

    // MARK: - IMAGE

    var image: UIImage?
    {
        get
        {
            return self.imageView.image
        }
        set
        {
            self.imageView.image = newValue
        }
    }
    
    @IBOutlet private var imageView: UIImageView!

    // MARK: - TITLE

    var title: String?
    {
        get
        {
            return self.titleLabel.text
        }
        set
        {
            self.titleLabel.text = newValue
        }
    }
    
    @IBOutlet private var titleLabel: UILabel!
}

