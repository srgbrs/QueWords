import UIKit
import InstantSearchVoiceOverlay

class SpeakingTrainingViewController: UIViewController, VoiceOverlayDelegate {
    func recording(text: String?, final: Bool?, error: Error?) {
        if let finalText = text, final == true {
            print(finalText)
            self.mainTextView.text = finalText
            highlightErrors(in: finalText)
        }
    }

    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var mainTextView: UITextView!
    
    @IBAction func onPlay(_ sender: UIButton) {
        voiceOverlay.start(on: self, textHandler: {text, final, _ in
            if final {
                print(text)
                 self.mainTextView.text = text
                
            } else {
                print("in progress \(text)")
                self.mainTextView.text = text
            }
        }, errorHandler: {error in
            
        })
    }
    

    var languageProcessor = LanguageProcessingService()
    
    let voiceOverlay : VoiceOverlayController = {
        let recordableHandler = {
          return SpeechController(locale: Locale(identifier: "en_US"))
        }
        return VoiceOverlayController(speechControllerHandler: recordableHandler)
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        voiceOverlay.delegate = self
        
        
        voiceOverlay.settings.showResultScreen = false
        setupVoiceTakerUI()
        mainTextView.layer.cornerRadius = 10
        mainTextView.clipsToBounds = true
        mainTextView.text = ""
        descriptionTextView.text = ""

    }
    
    func highlightErrors(in text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        let spellingErrors = languageProcessor.checkSpelling(in: text)

        print("Spelling errors found: \(spellingErrors)")

        for (word, range) in spellingErrors {
            if range.location != NSNotFound, NSMaxRange(range) <= text.utf16.count {
                attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
            }
        }

        DispatchQueue.main.async {
            self.mainTextView.attributedText = attributedString
        }
    }


    
    func setupVoiceTakerUI() {
        voiceOverlay.settings.layout.inputScreen.backgroundColor = .clear
        
        voiceOverlay.settings.layout.resultScreen.subtitle = ""
        voiceOverlay.settings.layout.resultScreen.startAgainText = ""
        voiceOverlay.settings.layout.resultScreen.title = ""
        voiceOverlay.settings.layout.resultScreen.titleProcessed = ""
        
        voiceOverlay.settings.layout.resultScreen.textColor = .clear
        
        voiceOverlay.settings.layout.inputScreen.textColor = .clear
        voiceOverlay.settings.layout.inputScreen.subtitleBulletList = []
    
        voiceOverlay.settings.layout.inputScreen.errorHint = ""
        voiceOverlay.settings.layout.inputScreen.titleListening = ""
        voiceOverlay.settings.layout.inputScreen.titleInProgress = ""
        voiceOverlay.settings.layout.inputScreen.titleInitial = ""
    }


    @IBAction func onBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
