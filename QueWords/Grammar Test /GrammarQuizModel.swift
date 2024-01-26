import Foundation

class GrammarQuizModel {
    static let shared = GrammarQuizModel()
    
    var questions: [GrammarQuestion] = [
        GrammarQuestion(question: "Complete the sentence: 'If I ___ rich, I would travel the world.'",
                        answers: ["am", "was", "were", "is"],
                        correctAnswerIndex: 2),
        GrammarQuestion(question: "What is the past tense of 'go'?",
                        answers: ["goed", "went", "gone", "goes"],
                        correctAnswerIndex: 1),
        GrammarQuestion(question: "Which is the correct plural form of 'child'?",
                        answers: ["childs", "children", "childes", "child"],
                        correctAnswerIndex: 1),
        GrammarQuestion(question: "Choose the correct form: 'She ___ a new car.'",
                        answers: ["buy", "buys", "bought", "have bought"],
                        correctAnswerIndex: 2),
        GrammarQuestion(question: "What is the superlative form of 'good'?",
                        answers: ["better", "goodest", "best", "gooder"],
                        correctAnswerIndex: 2),
        GrammarQuestion(question: "Complete the sentence: 'I ___ seen that movie before.'",
                        answers: ["has", "have", "had", "was"],
                        correctAnswerIndex: 1),
        GrammarQuestion(question: "Choose the correct preposition: 'I will meet you ___ the cinema.'",
                        answers: ["on", "in", "at", "by"],
                        correctAnswerIndex: 2),
        GrammarQuestion(question: "What is the past participle of 'write'?",
                        answers: ["writed", "wrote", "written", "write"],
                        correctAnswerIndex: 2),
        GrammarQuestion(question: "Choose the correct demonstrative pronoun: '___ book is mine.'",
                        answers: ["This", "That", "These", "Those"],
                        correctAnswerIndex: 0),
        GrammarQuestion(question: "Which word correctly completes the sentence: 'Nobody ___ the answer.'",
                        answers: ["know", "knows", "knew", "known"],
                        correctAnswerIndex: 1)
    ]
}
