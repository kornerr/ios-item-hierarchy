
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

    private func setupSample()
    {
        let storyboard = UIStoryboard.init(name: "SampleVC", bundle: nil)
        self.sampleVC = storyboard.instantiateViewController(withIdentifier: "SampleVC") as! SampleVC
        //self.sampleVC = SampleVC()
        self.rootVC = self.sampleVC

        // Create sections.
        self.sectionsView = UIView.loadFromNib()
        self.sampleVC.sectionsView = self.sectionsView

        self.setupSectionItemsWithoutImages()
    }

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
        // TODO Set images later through DispatchQueue to simulate their loading.
    }

    private func setupSectionItemsWithoutImages()
    {
        // Use MassEffect races as sections: http://masseffect.wikia.com/wiki/Races
        self.sectionsView.items = [
            SectionsItem("Asari"),
            SectionsItem("Drell"),
            SectionsItem("Elcor"),
            SectionsItem("Hanar"),
            SectionsItem("Humans"),
            SectionsItem("Keepers"),
            SectionsItem("Salarians"),
            SectionsItem("Turians"),
            SectionsItem("Volus"),
        ]
        // TODO Set images later through DispatchQueue to simulate their loading.
    }


}

