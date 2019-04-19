//
//  ThreeQuestionSeed.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import FluentMySQL

struct ThreeQuestionSeed: MySQLMigration {
  
  static func prepare(on connection: MySQLConnection) -> Future<Void> {
    return threeQuestion
      .map { question in question.save(on: connection) }
      .flatten(on: connection)
      .transform(to: ())
  }
  
  static func revert(on connection: MySQLConnection) -> Future<Void> {
    return .done(on: connection)
  }
}

fileprivate let threeQuestion = [
  ThreeQuestion(
    id: nil,
    number: 9,
    description: "I would come back to this conference"
  ),
  ThreeQuestion(
    id: nil,
    number: 10,
    description: "I would recommend the conference to someone else"
  )
]
