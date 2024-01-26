
import Foundation

class GrammarQuizViewModel {
    private var questions: [GrammarQuestion] = GrammarQuizModel.shared.questions
    private var currentQuestionIndex = 0
    
    var currentQuestion: GrammarQuestion {
        questions[currentQuestionIndex]
    }
    
    func checkAnswer(_ index: Int) -> Bool {
        return index == currentQuestion.correctAnswerIndex
    }
    
    func nextQuestion() -> Bool {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            return true
        }
        return false
    }
}

