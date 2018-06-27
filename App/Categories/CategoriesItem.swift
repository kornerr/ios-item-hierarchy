
import UIKit

struct CategoriesItem
{
    init(_ title: String, _ image: UIImage? = nil)
    {
        self.title = title
        self.image = image
    }

    var title = ""
    var image: UIImage?
}

