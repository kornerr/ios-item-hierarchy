
import UIKit

class SampleCoordinator: Coordinator
{

    // MARK: - SETUP

    override init()
    {
        super.init()
        self.setupSections()
        self.setupLoading()
        self.setupSample()
    }

    // MARK: - SECTIONS

    private var sectionsView: SectionsView!
    private var sectionsController: SectionsController!

    private func setupSections()
    {
        self.sectionsView = UIView.loadFromNib()
        self.sectionsController = SectionsController()
    }

    // MARK: - LOADING

    private var loadingView: LoadingView!

    private func setupLoading()
    {
        // Create loading view.
        self.loadingView = UIView.loadFromNib()
        self.loadingView.title = "Loading"
        self.loadingView.image = UIImage(named: "logo.cerberus.jpg")!

        // Display it when refreshing sections.
        self.sectionsController.refreshItemsExecutionChanged = { [weak self] in
            guard let this = self else { return }
            let isExecuting = this.sectionsController.refreshItemsIsExecuting
            this.sampleVC.loadingView = isExecuting ?  this.loadingView : nil
        }
    }

    // MARK: - SAMPLE

    private var sampleVC: SampleVC!

    private func setupSample()
    {
        // Create Sample VC.
        let storyboard = UIStoryboard.init(name: "SampleVC", bundle: nil)
        self.sampleVC = storyboard.instantiateViewController(withIdentifier: "SampleVC") as! SampleVC
        self.sampleVC.sectionsView = self.sectionsView
        // Display it.
        self.rootVC = self.sampleVC

        // Display items when they are ready.
        self.sectionsController.itemsChanged = { [weak self] in
            guard let this = self else { return }
            this.sectionsView.items = this.sectionsController.items
        }

        // Request items.
        self.sectionsController.refreshItems()
    }

}

