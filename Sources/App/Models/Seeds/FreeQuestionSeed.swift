//
//  FreeQuestionSeed.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import FluentMySQL

struct FreeQuestionSeed: MySQLMigration {
  
  static func prepare(on connection: MySQLConnection) -> Future<Void> {
    return freeQuestion
      .map { question in question.save(on: connection) }
      .flatten(on: connection)
      .transform(to: ())
  }
  
  static func revert(on connection: MySQLConnection) -> Future<Void> {
    return .done(on: connection)
  }
}

fileprivate let freeQuestion: [FreeQuestion] = [
  FreeQuestion(
    id: nil,
    number: 3,
    description: "What did you like about the workshops?"
  ),
  FreeQuestion(
    id: nil,
    number: 4,
    description: "How could the workshop you attended have been improved?"
  ),
  FreeQuestion(
    id: nil,
    number: 11,
    description: "Any other Feedback?"
  )
]
