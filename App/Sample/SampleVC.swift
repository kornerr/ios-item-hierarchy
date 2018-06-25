
import UIKit

class SampleVC: UIViewController
{

    // MARK: - SETUP

    var vcLoaded: SimpleCallback?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.updateSectionsView()
        if let report = self.vcLoaded
        {
            report()
        }
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

    @IBOutlet private var categoriesContainerView: UIView?
    
}
