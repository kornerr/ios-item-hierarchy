
import UIKit

class SampleCoordinator: Coordinator
{

    // MARK: - SETUP

    override init()
    {
        super.init()
        self.setupSections()
        self.setupCategories()
        self.setupLoading()
        self.setupSample()
    }

    // MARK: - SECTIONS

    private var sectionsView: SectionsView!

    private func setupSections()
    {
        self.sectionsView = UIView.loadFromNib()
    }

    // MARK: - CATEGORIES

    private var categoriesView: CategoriesView!
    private var categoriesController: CategoriesController!

    private func setupCategories()
    {
        self.categoriesView = UIView.loadFromNib()

        self.categoriesController = CategoriesController()
        let image = UIImage(named: "blurred.logo.cerberus.jpg")!
        self.categoriesController.placeholderItemImage = image
    }

    // MARK: - LOADING

    private var loadingView: LoadingView!

    private func setupLoading()
    {
        // Create loading view.
        self.loadingView = UIView.loadFromNib()
        self.loadingView.title = "Loading"
        self.loadingView.image = UIImage(named: "logo.cerberus.jpg")!

        // Display it when refreshing categories.
        self.categoriesController.refreshExecutionChanged = { [weak self] in
            guard let this = self else { return }
            let isExecuting = this.categoriesController.refreshIsExecuting
            this.sampleVC.loadingView = isExecuting ?  this.loadingView : nil
        }
    }

    // MARK: - SAMPLE

    private var sampleVC: SampleVC!

    private func setupSample()
    {
        // Create and configure Sample VC.
        let storyboard = UIStoryboard.init(name: "SampleVC", bundle: nil)
        self.sampleVC = storyboard.instantiateViewController(withIdentifier: "SampleVC") as! SampleVC
        self.sampleVC.sectionsView = self.sectionsView
        self.sampleVC.categoriesView = self.categoriesView
        // Display it.
        self.rootVC = self.sampleVC

        // Display sections and categories.
        self.categoriesController.itemsChanged = { [weak self] in
            guard let this = self else { return }
            // Display sections.
            let sections = this.categoriesController.itemsRoot.children
            this.sectionsView.items = sections
            // Display selected section categories right after loading.
            this.categoriesView.items = sections[this.sectionsView.selectedItemId].children
        }

        // Display selected section categories.
        self.sectionsView.selectedItemChanged = { [weak self] in
            guard let this = self else { return }
            let sections = this.categoriesController.itemsRoot.children
            this.categoriesView.items = sections[this.sectionsView.selectedItemId].children
        }

        // Request items.
        self.categoriesController.refresh()
    }

}

