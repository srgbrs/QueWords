import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    
    @IBAction func onWritingTraining(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WritingTrainingViewController") as? WritingTrainingViewController {
            present(vc, animated: true)
        }
    }
    
    @IBAction func onSpeaking(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpeakingTrainingViewController") as? SpeakingTrainingViewController {
            present(vc, animated: true)
        }
    }
    @IBAction func onGrammarTest(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GrammarQuizViewController") as? GrammarQuizViewController {
            present(vc, animated: true)
        }
    }


}
