
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

    private var collapsePanGR: UIPanGestureRecognizer!

    private func setupSectionsCategoriesCollapse()
    {
        self.collapsePanGR =
            UIPanGestureRecognizer(target: self, action: #selector(collapsePan(_:)))
        self.collapsePanGR.delegate = self
        self.view.addGestureRecognizer(self.collapsePanGR)
    }

    @objc func collapsePan(_ recognizer: UIPanGestureRecognizer)
    {
        SAMPLE_VC_LOG("TODO pan to collapse/expand")
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
    
}
