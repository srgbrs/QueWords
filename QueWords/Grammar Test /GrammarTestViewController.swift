import UIKit

class GrammarQuizViewController: UIViewController {
    
    @IBOutlet weak var labelT: UITextView!
 
    @IBOutlet weak var q1: UIButton!
    
    @IBOutlet weak var q2: UIButton!
    private let viewModel = GrammarQuizViewModel()

    @IBOutlet weak var a4: UIButton!
    @IBOutlet weak var q3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentQuestion()
    }
    
    private func displayCurrentQuestion() {
        let currentQuestion = viewModel.currentQuestion
        labelT.text = currentQuestion.question
        q1.setTitle(currentQuestion.answers[0], for: .normal)
        q2.setTitle(currentQuestion.answers[1], for: .normal)
        q3.setTitle(currentQuestion.answers[2], for: .normal)
        a4.setTitle(currentQuestion.answers[3], for: .normal)
        resetButtonColors()
    }
    
    private func resetButtonColors() {
        q1.backgroundColor = .clear
        q2.backgroundColor = .clear
        q3.backgroundColor = .clear
        a4.backgroundColor = .clear
    }

    @IBAction func onBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let isCorrect = viewModel.checkAnswer(index)

        sender.backgroundColor = isCorrect ? .green : .red
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.viewModel.nextQuestion() {
                self.displayCurrentQuestion()
            } else {
        
            }
        }
    }
}
