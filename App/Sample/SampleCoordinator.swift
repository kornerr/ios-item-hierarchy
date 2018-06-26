
import UIKit

class SampleCoordinator: Coordinator
{

    override init()
    {
        super.init()
        self.setupSample()
    }

    private var sampleVC: SampleVC!
    private var sectionsView: SectionsView!
    private var loadingView: LoadingView!

    private func setupSample()
    {
        let storyboard = UIStoryboard.init(name: "SampleVC", bundle: nil)
        self.sampleVC = storyboard.instantiateViewController(withIdentifier: "SampleVC") as! SampleVC
        self.rootVC = self.sampleVC

        // Create sections.
        self.sectionsView = UIView.loadFromNib()
        self.sampleVC.sectionsView = self.sectionsView

        // Create loading.
        self.loadingView = UIView.loadFromNib()
        self.loadingView.image = UIImage(named: "logo.cerberus.jpg")!
        self.loadingView.title = "Loading"

        self.simulateLoading()
    }

    /*
    private func setupSectionItems()
    {
        // Use MassEffect races as sections: http://masseffect.wikia.com/wiki/Races
        self.sectionsView.items = [
            SectionsItem(
                "Asari",
                UIImage(named: "race.asari.png")!
            ),
            SectionsItem(
                "Drell",
                UIImage(named: "race.drell.png")!
            ),
            SectionsItem(
                "Elcor",
                UIImage(named: "race.elcor.png")!
            ),
            SectionsItem(
                "Hanar",
                UIImage(named: "race.hanar.png")!
            ),
            SectionsItem(
                "Humans",
                UIImage(named: "race.humans.jpg")!
            ),
            SectionsItem(
                "Keepers",
                UIImage(named: "race.keeper.png")!
            ),
            SectionsItem(
                "Salarians",
                UIImage(named: "race.salarians.png")!
            ),
            SectionsItem(
                "Turians",
                UIImage(named: "race.turians.png")!
            ),
            SectionsItem(
                "Volus",
                UIImage(named: "race.volus.png")!
            ),
        ]
    }
    */

    private func setupSectionItemsWithStubImages()
    {
        // Provide stub image before real one has been loaded.
        let image = UIImage(named: "blurred.logo.cerberus.jpg")!
        self.sectionsView.items = [
            SectionsItem("Asari", image),
            SectionsItem("Drell", image),
            SectionsItem("Elcor", image),
            SectionsItem("Hanar", image),
            SectionsItem("Humans", image),
            SectionsItem("Keepers", image),
            SectionsItem("Salarians", image),
            SectionsItem("Turians", image),
            SectionsItem("Volus", image),
        ]
        // TODO Set images later through DispatchQueue to simulate their loading.
    }

    // MARK: - LOADING SIMULATION

    private func simulateLoading()
    {
        // Display loading view.
        self.sampleVC.loadingView = self.loadingView

        // Load sections.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Provide sections.
            self.setupSectionItemsWithStubImages()
            // Hide loading view.
            self.sampleVC.loadingView = nil

            // Go on.
            self.simulateLoadingOfSectionImages()
        }
    }

    private func simulateLoadingOfSectionImages()
    {
        // TODO
    }

}

