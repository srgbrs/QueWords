import Foundation
import UIKit
import NaturalLanguage

class WritingTrainingViewModel {
    private var currentTaskIndex = 0
    private var writingTasks = WritingTask.writingTasks

    func getCurrentTask() -> WritingTask? {
        guard currentTaskIndex < writingTasks.count else { return nil }
        return writingTasks[currentTaskIndex]
    }

    func processUserResponse(_ response: String, completion: @escaping (Bool, Double, NSAttributedString, String) -> Void) {
        guard let currentTask = getCurrentTask() else { return }

        let count = countOccurrences(of: currentTask.wordType, in: response)
        let coefficient = min(Double(count) / Double(currentTask.quantity), 1.0)
        let highlightedText = highlightOccurrences(of: currentTask.wordType, in: response)
        let isCorrect = coefficient >= 1.0

        let feedback = isCorrect ? "Great job!" : "Write \(currentTask.quantity - count) more \(currentTask.wordType.rawValue.lowercased())"

        completion(isCorrect, coefficient, highlightedText, feedback)
    }


    func goToNextTask() {
        if currentTaskIndex < writingTasks.count - 1 {
            currentTaskIndex += 1
        }
        // Handle completion of all tasks or loop back to the first
    }

    private func countOccurrences(of wordType: WordType, in text: String) -> Int {
        var count = 0
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = text

        let range = text.startIndex..<text.endIndex
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass) { tag, _ in
            if tag?.rawValue == wordType.rawValue {
                count += 1
            }
            return true
        }

        return count
    }

    private func highlightOccurrences(of wordType: WordType, in text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = text

        let range = text.startIndex..<text.endIndex
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass) { tag, tokenRange in
            if tag?.rawValue == wordType.rawValue {
                attributedString.addAttributes([
                    .foregroundColor: UIColor.green,
                    .font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
                ], range: NSRange(tokenRange, in: text))
            }
            return true
        }

        return attributedString
    }

}
