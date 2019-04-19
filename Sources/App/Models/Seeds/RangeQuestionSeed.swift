//
//  SeedQuestions.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import FluentMySQL

struct RangeQuestionSeed: MySQLMigration {
  
  static func prepare(on connection: MySQLConnection) -> Future<Void> {
    return rangeQuestion
      .map { question in question.save(on: connection) }
      .flatten(on: connection)
      .transform(to: ())
  }
  
  static func revert(on connection: MySQLConnection) -> Future<Void> {
    return .done(on: connection)
  }
}

fileprivate let rangeQuestion = [
  RangeQuestion(
    id: nil,
    number: 2,
    description: "How did you find the quality of the workshops?"
  ),
  RangeQuestion(
    id: nil,
    number: 6,
    description: "Overall how did you enjoy the conference"
  ),
  RangeQuestion(
    id: nil,
    number: 7,
    description: "How did you find the quality of the talks?"
  ),
  RangeQuestion(
    id: nil,
    number: 8,
    description: "How did you find the quality of the food?"
  )
]
