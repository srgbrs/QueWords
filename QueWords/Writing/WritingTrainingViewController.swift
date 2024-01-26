import UIKit
import NaturalLanguage

class WritingTrainingViewController: UIViewController {
    @IBOutlet weak var wordsForDictionaryTableView: UITableView!
    @IBOutlet weak var writingFieldTextView: UITextView!
    @IBOutlet weak var commentsTextView: UITextView!
    
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    
    private let viewModel = WritingTrainingViewModel()
    private var cues: [Cue<WritingTask>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writingFieldTextView.text = ""
        commentsTextView.text = ""
        displayCurrentTask()
        
        writingFieldTextView.layer.cornerRadius = 10
        writingFieldTextView.clipsToBounds = true
    }
    
    private func displayCurrentTask() {
        if let currentTask = viewModel.getCurrentTask() {
            taskDescriptionTextView.text = currentTask.description
        }
    }
    
    @IBAction func onMainButtonTapped(_ sender: UIButton) {
        guard let userText = writingFieldTextView.text else { return }
        
        viewModel.processUserResponse(userText) { [weak self] (isCorrect, coefficient, highlightedText, feedback) in
            self?.writingFieldTextView.attributedText = highlightedText
            self?.commentsTextView.text = feedback

            if isCorrect {
                self?.writingFieldTextView.text = ""  // Clearing the field
                self?.viewModel.goToNextTask()
                self?.displayCurrentTask()
            }
        }
    }
    @IBAction func onBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
