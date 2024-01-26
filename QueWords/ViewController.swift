import UIKit
import NaturalLanguage
import CoreML

class ViewController: UIViewController {

    
    @IBOutlet weak var userTextView: UITextView!
    @IBOutlet weak var resultTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextView.text = ""
        resultTextView.text = ""

        identifyPhrasalVerbs(in: "Police are looking into connections between the two crimes")
        checkSpelling(in: "He go to schol eferyday.")
        
        let synonymsList = synonyms(for: "happy")
        print("Synonyms for 'happy': \(synonymsList)")

        let wordDistance = distanceBetween(word: "happy", and: "joyful")
        print("Distance between 'happy' and 'joyful': \(wordDistance)")

        let sentenceDistance = distanceBetween(sentence: "How are you?", and: "What's up?")
        print("Distance between sentences: \(sentenceDistance)")
    }
    
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
    

    func checkSpelling(in text: String) {
        let textChecker = UITextChecker()
        let range = NSRange(0..<text.utf16.count)

        var misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en")
        while misspelledRange.location != NSNotFound {
            let misspelledWord = (text as NSString).substring(with: misspelledRange)
            print("Misspelled word: \(misspelledWord)")
            let start = misspelledRange.upperBound
            misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: NSRange(start..<text.utf16.count), startingAt: start, wrap: false, language: "en")
        }
    }
    
    func identifyPhrasalVerbs(in sentence: String) {
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = sentence
        let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation, .joinNames]

        var previousWord: (word: String, tag: NLTag)?
        tagger.enumerateTags(in: sentence.startIndex..<sentence.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag {
                let currentWord = String(sentence[tokenRange])
                
            
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


    @IBAction func onMainButtonTapped(_ sender: UIButton) {
         let userText = userTextView.text
      
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

            tagger.enumerateTags(in: sentence.startIndex..<sentence.endIndex, unit: .word, scheme: .lexicalClass) { tag, tokenRange in
                print("\(sentence[tokenRange]): \(tag?.rawValue ?? "unknown")")
                return true
            }


            let wordCount = sentence.split(separator: " ").count
            print("Word count: \(wordCount)")

      
            
            print("-----")
        }
    }
}

class NLLanguageProcessor {
    
    func analyzeText(_ text: String) -> String {
        return ""
    }
}


