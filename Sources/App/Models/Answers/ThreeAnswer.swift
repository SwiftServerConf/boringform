//
//  ThreeAnswer.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import Vapor
import FluentMySQL

struct ThreeAnswer: MySQLModel {
  var id: Int?
  let questionID: Int
  
  let answer: String
}

extension ThreeAnswer: Content {}
extension ThreeAnswer: Migration {}

extension ThreeAnswer {
  init(from form: ThreeAnswerForm) {
    self.init(
      id: nil,
      questionID: form.questionID,
      answer: form.answer
    )
  }
}
