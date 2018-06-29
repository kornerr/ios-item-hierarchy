
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
        self.setupSectionsCategoriesCollapse()
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

    private let collapseDelta: CGFloat = 50
    private let collapseDuration: TimeInterval = 0.2
    @IBOutlet private var expandedLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private var contentView: UIView!
    private var collapsePanGR: UIPanGestureRecognizer!

    private var collapse: SimpleCallback?
    private var expand: SimpleCallback?

    private func setupSectionsCategoriesCollapse()
    {
        self.collapsePanGR =
            UIPanGestureRecognizer(target: self, action: #selector(collapsePan(_:)))
        self.collapsePanGR.delegate = self
        self.view.addGestureRecognizer(self.collapsePanGR)
        self.setupCollapseExpansionHandling()
    }

    @objc func collapsePan(_ recognizer: UIPanGestureRecognizer)
    {
        guard
            let view = recognizer.view 
        else
        {
            SAMPLE_VC_LOG("ERROR Gesture recognizer has no view. Cannot proceed")
            return
        }
        let translation = recognizer.translation(in: view)
        let doCollapse = (translation.y < 0)
        if fabs(translation.y) > collapseDelta
        {
            // Report collapse.
            if 
                doCollapse,
                let report = collapse
            {
                report()
            }
            // Report expansion.
            if 
                !doCollapse,
                let report = expand
            {
                report()
            }
        }
    }

    func gestureRecognizerShouldBegin(
        _ gestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        guard
            let recognizer = gestureRecognizer as? UIPanGestureRecognizer
        else
        {
            return false
        }
        let translation = recognizer.translation(in: self.view)
        // Prefer vertical pan.
        return fabs(translation.y) > fabs(translation.x)
    }

    private func setupCollapseExpansionHandling()
    {
        self.collapse = { [weak self] in
            guard let this = self else { return }
            this.performCollapse(true)
        }
        self.expand = { [weak self] in
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
            withDuration: self.collapseDuration,
            animations: animations,
            completion: completion
        )
    }

}
