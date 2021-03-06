
import UIKit

class LoadingView: UIView
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.updateSpinnerColor()
        self.updateTitleColor()
        self.updateTitleText()
        self.updateImage()
    }
    
    // MARK: - IMAGE
    
    var image: UIImage?
    {
        get
        {
            return _image
        }
        set
        {
            _image = newValue
            self.updateImage()
        }
    }
    private var _image: UIImage?

    @IBOutlet private var imageView: UIImageView!

    private func updateImage()
    {
        self.imageView.image = self.image
    }
    
    // MARK: - COLOR

    var color: UIColor
    {
        get
        {
            return _color
        }
        set
        {
            _color = newValue
            self.updateSpinnerColor()
            self.updateTitleColor()
        }
    }
    private var _color: UIColor = .black

    // MARK: - SPINNER

    @IBOutlet private var spinnerView: UIActivityIndicatorView!
    
    private func updateSpinnerColor()
    {
        self.spinnerView.color = self.color
    }

    // MARK: - TITLE
    
    var title: String?
    {
        get
        {
            return _title
        }
        set
        {
            _title = newValue
            self.updateTitleText()
        }
    }
    private var _title: String?

    @IBOutlet private var titleLabel: UILabel!

    private func updateTitleColor()
    {
        self.titleLabel.textColor = self.color
    }

    private func updateTitleText()
    {
        self.titleLabel.text = self.title
    }

}

