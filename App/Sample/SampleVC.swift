
import UIKit

private func SAMPLE_VC_LOG(_ message: String)
{
    NSLog("SampleVC \(message)")
}

class SampleVC: UIViewController, UIGestureRecognizerDelegate
{

    // MARK: - SETUP

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.updateSectionsView()
        self.updateCategoriesView()
        self.updateLoadingView()
        self.setupSectionsCategoriesCollapseExpansion()
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
    
    // MARK: - PRODUCTS
    
    // TODO
    
    @IBOutlet private var productsContainerView: UIView!
    
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

    // MARK: - SECTIONS AND CATEGORIES COLLAPSE

    private var collapseExpansionDetector: CollapseExpansionDetector!
    private let animationDuration: TimeInterval = 0.2

    @IBOutlet private var expandedLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private var contentView: UIView!

    private func setupSectionsCategoriesCollapseExpansion()
    {
        self.collapseExpansionDetector = CollapseExpansionDetector(trackedView: self.view)
        self.collapseExpansionDetector.collapse = { [weak self] in
            guard let this = self else { return }
            this.performCollapse(true)
        }
        self.collapseExpansionDetector.expand = { [weak self] in
            guard let this = self else { return }
            this.performCollapse(false)
        }
    }

    private var isPerformingCollapse = false
    private func performCollapse(_ collapse: Bool)
    {
        // Do nothing if already performing collapse.
        if self.isPerformingCollapse
        {
            return
        }
        self.isPerformingCollapse = true

        SAMPLE_VC_LOG("perform collapse '\(collapse)'")

        // Change layout.
        self.expandedLayoutConstraint.isActive = !collapse

        // Animate.
        let animations: SimpleCallback = { [weak self] in
            self?.contentView.layoutIfNeeded()
        }
        let completion: (Bool) -> Void = { [weak self] _ in
            self?.isPerformingCollapse = false
        }
        UIView.animate(
            withDuration: self.animationDuration,
            animations: animations,
            completion: completion
        )
    }

}
