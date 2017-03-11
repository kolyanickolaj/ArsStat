
import UIKit

class InfoShowViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    var language: String?
    
    @IBAction func didTapOK(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var okButton: UIButton!

    
    let engInfoText = "Thank you for downloading ArsStat. This app was developed by Mikalai Lipski as a result of iOS-development courses provided by \"Educational center of HTP in Minsk, Republic of Belarus.\" If you find it nice, I would be happy if you will tell your friends about this app. It's very simple, just use one of links below. Thank You!"
    let rusInfoText = "Благодарю Вас за использование ArsStat. Это приложение разработано Липским Николаем и является выпускным проектом курсов по iOS-разработке, которые проводит Образовательный центр ПВТ в Минске, Беларусь. Если Вам понравилось это приложение, расскажите о нем своим друзьям. Это легко, просто воспользуйтесь одной из ссылок ниже. Спасибо!"
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if language == "ENG" {
        infoLabel.text = engInfoText
        } else {infoLabel.text = rusInfoText}

        }
    
    override func viewWillAppear(_ animated: Bool) {
        okButton.layer.borderWidth = 1
        okButton.layer.borderColor = UIColor.white.cgColor
        okButton.layer.cornerRadius = 10
    }


  }
