
import Foundation

private func COLLAPSE_EXPANSION_DETECTOR_LOG(_ message: String)
{
    NSLog("CollapseExpansionDetector \(message)")
}

// Detect collapse/expansion when panning vertically.
class CollapseExpansionDetector: NSObject, UIGestureRecognizerDelegate
{

    var actionDelta: CGFloat = 50
    var collapse: SimpleCallback?
    var expand: SimpleCallback?

    private var recognizer: UIPanGestureRecognizer!

    init(trackedView: UIView)
    {
        super.init()
        
        self.recognizer =
            UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        self.recognizer.delegate = self
        trackedView.addGestureRecognizer(self.recognizer)
    }

    @objc func pan(_ recognizer: UIPanGestureRecognizer)
    {
        guard
            let view = recognizer.view 
        else
        {
            COLLAPSE_EXPANSION_DETECTOR_LOG("ERROR Gesture recognizer has no view. Cannot proceed")
            return
        }
        let translation = recognizer.translation(in: view)
        let checkCollapse = (translation.y < 0)
        if fabs(translation.y) > self.actionDelta
        {
            // Report collapse.
            if 
                checkCollapse,
                let report = collapse
            {
                report()
            }
            // Report expansion.
            if 
                !checkCollapse,
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
            let recognizer = gestureRecognizer as? UIPanGestureRecognizer,
            let view = recognizer.view 
        else
        {
            return false
        }
        let translation = recognizer.translation(in: view)
        // Prefer vertical pan.
        return fabs(translation.y) > fabs(translation.x)
    }

}

