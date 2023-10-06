import Foundation

struct Question:Codable{
    let id:Int
    let question_num:Int
    let activity:String
    let description:String
    
}
typealias Questions = [Question]

enum QuestionError: Error, LocalizedError{
    case itemNotFound
    case tokenGenerationFailed
    case tokenExtractionFailed
}

extension Question {
    
    


}
