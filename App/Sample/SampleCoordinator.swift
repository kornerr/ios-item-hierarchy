
import UIKit

class SampleCoordinator: Coordinator
{

    // MARK: - SETUP

    override init()
    {
        super.init()
        self.setupSections()
        self.setupCategories()
        self.setupProducts()
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

    // MARK: - PRODUCTS

    private var productsView: ProductsView!
    private var productsController: ProductsController!

    private func setupProducts()
    {
        self.productsView = UIView.loadFromNib()

        self.productsController = ProductsController()
        let image = UIImage(named: "blurred.logo.cerberus.jpg")!
        self.productsController.placeholderItemImage = image
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
        self.sampleVC.productsView = self.productsView
        // Display it.
        self.rootVC = self.sampleVC

        // Display sections and categories.
        self.categoriesController.itemsChanged = { [weak self] in
            guard let this = self else { return }
            // Display sections.
            let sections = this.categoriesController.itemsRoot.children
            this.sectionsView.items = sections
        }

        // Display selected section categories.
        self.sectionsView.selectedItemChanged = { [weak self] in
            guard let this = self else { return }
            let sections = this.categoriesController.itemsRoot.children
            this.categoriesView.items = sections[this.sectionsView.selectedItemId].children
        }

        // Request products of the selected category.
        self.categoriesView.selectedItemChanged = { [weak self] in
            guard let this = self else { return }
            // TODO request products of the specific category.
        }
        // Request products of the selected category.
        self.productsController.itemsChanged = { [weak self] in
            guard let this = self else { return }
            this.productsView.items = this.productsController.items
        }

        // Request items.
        self.categoriesController.refresh()

        // TODO request products of the specific category.
        self.productsController.refresh()
    }

}

