import Foundation
import NaturalLanguage
import UIKit
import CoreML

class LanguageProcessingService {
    func distanceBetween(sentence: String, and anotherSentence: String) -> Double {
        guard let embedding = NLEmbedding.sentenceEmbedding(for: .english) else { return -1 }
        return embedding.distance(between: sentence, and: anotherSentence)
    }
    
    func distanceBetween(word: String, and anotherWord: String) -> Double {
        guard let embedding = NLEmbedding.wordEmbedding(for: .english) else { return -1 }
        return embedding.distance(between: word, and: anotherWord)
    }
    
    func synonyms(for word: String, maximumCount: Int = 5) -> [String] {
        guard let embedding = NLEmbedding.wordEmbedding(for: .english) else { return [] }
        return embedding.neighbors(for: word, maximumCount: maximumCount).map { $0.0 }
    }
    
    func findAdjectives(in text: String) -> [Range<String.Index>] {
        var adjectiveRanges: [Range<String.Index>] = []
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = text

        let range = text.startIndex..<text.endIndex
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass) { tag, tokenRange in
            if tag == .adjective {
                adjectiveRanges.append(tokenRange)
            }
            return true
        }

        return adjectiveRanges
    }
    
    func baseForm(for word: String) -> String {
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = word
        let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation, .joinNames]
        let range = word.startIndex..<word.endIndex

        var baseForm: String = word

        tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { tag, tokenRange in
            if let lemma = tag?.rawValue {
                baseForm = lemma
            }
            return false
        }

        return baseForm
    }

    func checkSpelling(in text: String) -> [(word: String, range: NSRange)] {
        let textChecker = UITextChecker()
        let range = NSRange(0..<text.utf16.count)
        var misspelledRanges = [(word: String, range: NSRange)]()

        var startPosition = 0
        while startPosition < text.utf16.count {
            let misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: NSRange(location: startPosition, length: text.utf16.count - startPosition), startingAt: startPosition, wrap: false, language: "en")

            if misspelledRange.location != NSNotFound {
                let misspelledWord = (text as NSString).substring(with: misspelledRange)
                misspelledRanges.append((word: misspelledWord, range: misspelledRange))
                startPosition = misspelledRange.upperBound
            } else {
                break
            }
        }

        return misspelledRanges
    }

    
    func identifyPhrasalVerbs(in sentence: String) {
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = sentence
        let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation, .joinNames]

        var previousWord: (word: String, tag: NLTag)?
        tagger.enumerateTags(in: sentence.startIndex..<sentence.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag {
                let currentWord = String(sentence[tokenRange])
                
                // Check for contraction (like "couldn't") and treat it as a verb
                let isContraction = currentWord.contains("’") || currentWord.contains("'")
                let effectiveTag = isContraction ? NLTag.verb : tag

                if effectiveTag == .verb || (tag == .adverb && previousWord?.tag == .verb) || (tag == .preposition && previousWord?.tag == .verb) {
                    if let previous = previousWord, previous.tag == .verb && (tag == .adverb || tag == .preposition) {
                        print("Potential phrasal verb: \(previous.word) \(currentWord)")
                    }
                    previousWord = (currentWord, effectiveTag)
                } else {
                    previousWord = nil
                }
            }
            return true
        }
    }

    func autoComplete(for incompleteWord: String) {
        let textChecker = UITextChecker()
        let range = NSRange(0..<incompleteWord.utf16.count)
        let guesses = textChecker.completions(forPartialWordRange: range, in: incompleteWord, language: "en") ?? []
        
        print("Autocomplete suggestions for '\(incompleteWord)': \(guesses)")
    }
    
    func lemmatize(sentence: String) {
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = sentence
        let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation, .joinNames]

        tagger.enumerateTags(in: sentence.startIndex..<sentence.endIndex, unit: .word, scheme: .lemma, options: options) { tag, tokenRange in
            if let lemma = tag?.rawValue {
                print("\(sentence[tokenRange]): \(lemma)")
            }
            return true
        }
    }
    
    func analyzeSentences() {
        let sentences = [
            "The quick brown fox jumps over the lazy dog.",
            "Despite the heavy rains, the event continued as planned.",
            "Can you imagine an AI writing poems in the moonlight?"
        ]

        for sentence in sentences {
            print("Analyzing sentence: \(sentence)")
            let tagger = NLTagger(tagSchemes: [.lexicalClass, .lemma])
            tagger.string = sentence

            // Parts of speech tagging
            tagger.enumerateTags(in: sentence.startIndex..<sentence.endIndex, unit: .word, scheme: .lexicalClass) { tag, tokenRange in
                print("\(sentence[tokenRange]): \(tag?.rawValue ?? "unknown")")
                return true
            }

            // Sentence complexity analysis
            let wordCount = sentence.split(separator: " ").count
            print("Word count: \(wordCount)")

            // You can add more complexity analysis here
            // ...
            
            print("-----")
        }
    }
}
