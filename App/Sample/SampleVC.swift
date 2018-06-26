
import UIKit

class SampleVC: UIViewController
{

    // MARK: - SETUP

    var vcLoaded: SimpleCallback?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.updateSectionsView()
        self.updateLoadingView()
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

    // MARK: - LOADING

    @IBOutlet private var loadingContainerView: UIView?

    var loadingView: UIView?
    {
        get
        {
            return _loadingView
        }
        set
        {
            _loadingView = newValue
            self.updateLoadingView()
        }
    }
    private var _loadingView: UIView?

    func updateLoadingView()
    {
        self.loadingContainerView?.embeddedView = self.loadingView
        self.loadingContainerView?.isHidden = (self.loadingView == nil)
    }
    
}
