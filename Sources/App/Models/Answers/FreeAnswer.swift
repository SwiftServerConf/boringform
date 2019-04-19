//
//  FreeAnswer.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import Vapor
import FluentMySQL

struct FreeAnswer: MySQLModel {
  var id: Int?
  let questionID: Int
  
  let description: String
}

extension FreeAnswer: Content {}
extension FreeAnswer: Migration {}

extension FreeAnswer {
  init(from form: FreeAnswerForm) {
    self.init(
      id: nil,
      questionID: form.questionID,
      description: form.description
    )
  }
}
