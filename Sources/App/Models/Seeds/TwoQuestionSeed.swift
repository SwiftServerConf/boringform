//
//  TwoQuestionSeed.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import FluentMySQL

struct TwoQuestionSeed: MySQLMigration {
  
  static func prepare(on connection: MySQLConnection) -> Future<Void> {
    return TwoQuestion(
      id: nil,
      number: 5,
      description: "I attend the following conference days"
    ).save(on: connection).transform(to: ())
  }
  
  static func revert(on connection: MySQLConnection) -> Future<Void> {
    return .done(on: connection)
  }
}
