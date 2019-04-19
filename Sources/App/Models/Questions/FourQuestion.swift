//
//  FourQuestion.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import Vapor
import FluentMySQL

final class FourQuestion: Question, MySQLModel {
  var id: Int?
  let number: Int
  let description: String
  
  init(id: Int? = nil, number: Int, description: String) {
    self.id = id
    self.number = number
    self.description = description
  }
  
  var answer: Children<FourQuestion, FourAnswer> {
    return children(\.questionID)
  }
}

extension FourQuestion: Migration {}
extension FourQuestion: Content {}

extension FourQuestion {
  // Since each question has a unique number (not id)
  // we filter for the question providing a number and
  // then ensure the result is of count 1 and return that
  static func find(on req: Request, byNumber: Int) throws -> Future<FourQuestion> {
    return FourQuestion
      .query(on: req)
      .filter(\FourQuestion.number, .equal, byNumber)
      .all()
      .map { questionList in
        try questionList.validateUniqueness(for: byNumber)
        return questionList.first!
    }
  }
}
