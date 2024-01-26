import Foundation

struct WritingTask {
    let description: String
    let wordType: WordType
    let quantity: Int
    
    static var writingTasks: [WritingTask] = [
        WritingTask(description: "Write a short story using 3 adjectives.", wordType: .adjective, quantity: 3),
        WritingTask(description: "Describe your favorite place using 5 adjectives.", wordType: .adjective, quantity: 5),
        WritingTask(description: "Write a text with usage of 'the/a' 5 times.", wordType: .article, quantity: 5),
        WritingTask(description: "Write a story about a monkey using 4 adjectives describing its appearance.", wordType: .adjective, quantity: 4),
        WritingTask(description: "Create a dialogue between two characters, using at least 3 pronouns.", wordType: .pronoun, quantity: 3),
        WritingTask(description: "Write a paragraph about your last holiday, including 2 adverbs.", wordType: .adverb, quantity: 2),
        WritingTask(description: "Compose a short poem using 2 conjunctions.", wordType: .conjunction, quantity: 2),
        WritingTask(description: "Write five sentences about your city, using a different verb in each one.", wordType: .verb, quantity: 5),
        WritingTask(description: "Introduce yourself in a paragraph, using 3 nouns related to your hobbies.", wordType: .noun, quantity: 3),
        WritingTask(description: "Describe a memorable event using 2 interjections.", wordType: .interjection, quantity: 2)
    ]

}
