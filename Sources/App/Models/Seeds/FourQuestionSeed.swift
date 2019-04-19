//
//  SeedFourQuestion.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import FluentMySQL

struct FourQuestionSeed: MySQLMigration {
  
  static func prepare(on connection: MySQLConnection) -> Future<Void> {
    return FourQuestion(
      id: nil,
      number: 1,
      description: "I attended the following workshops"
    ).save(on: connection).transform(to: ())
  }
  
  static func revert(on connection: MySQLConnection) -> Future<Void> {
    return .done(on: connection)
  }
}
