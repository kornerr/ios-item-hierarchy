
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    // MARK: - SETUP

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        // Create window.
        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.setupCoordinator()

        // Display window.
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        return true
    }

    // MARK: - COORDINATOR

    private var coordinator: Coordinator!

    private func setupCoordinator()
    {
        self.coordinator = SampleCoordinator()
        self.window!.rootViewController = self.coordinator.rootVC

        // If root VC changes, re-assign it to the window.
        self.coordinator.rootVCChanged = { [weak self] in
            guard let this = self else { return }
            this.window!.rootViewController = this.coordinator.rootVC
        }
    }

}

