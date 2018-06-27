
import UIKit

class SampleVC: UIViewController
{

    // MARK: - SETUP

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.updateSectionsView()
        self.updateCategoriesView()
        self.updateLoadingView()
    }
    
    // MARK: - SECTIONS
    
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

    var categoriesView: UIView?
    {
        get
        {
            return _categoriesView
        }
        set
        {
            _categoriesView = newValue
            self.updateCategoriesView()
        }
    }
    private var _categoriesView: UIView?

    private func updateCategoriesView()
    {
        self.categoriesContainerView?.embeddedView = self.categoriesView
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
        // NOTE We do not remove embedded view because it's ugly
        // NOTE for animated visibility change.
        if let view = self.loadingView
        {
            self.loadingContainerView?.embeddedView = view
        }
        let isVisible = (self.loadingView != nil)
        self.loadingContainerView?.setVisible(isVisible, animated: true)
    }
    
}
