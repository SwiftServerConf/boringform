//
//  Array+Question.swift
//  App
//
//  Created by Martin Lasek on 16.04.19.
//

// Helper to ensure that a question queried
// with a number returns an array with only one result
// `number` is a unique identifier
extension Array where Element: Question {
  func validateUniqueness(for number: Int) throws {
    if self.count != 1 {
      throw QuestionError.questionNotFound(number: number)
    }
  }
}
