
import UIKit

class SampleVC: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.updateSectionsView()
    }
    
    // MARK: - SECTIONS VIEW
    
    @IBOutlet private var sectionsContainerView: UIView?

    var sectionsView: UIView?
    {
        get
        {
            return _sectionsView
        }
        set
        {
            _sectionsView = newValue
            self.updateSectionsView()
        }
    }
    private var _sectionsView: UIView?

    private func updateSectionsView()
    {
        self.sectionsContainerView?.embeddedView = self.sectionsView
    }

    // MARK: - CATEGORIES

    @IBOutlet private var categoriesContainerView: UIView!
    
}
