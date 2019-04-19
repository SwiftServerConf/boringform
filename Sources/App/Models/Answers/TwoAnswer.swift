//
//  TwoAnswer.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import Vapor
import FluentMySQL

struct TwoAnswer: MySQLModel {
  var id: Int?
  let questionID: Int
  
  let thursday: Bool
  let friday: Bool
}

extension TwoAnswer: Content {}
extension TwoAnswer: Migration {}

extension TwoAnswer {
  init(from form: TwoAnswerForm) {
    self.init(
      id: nil,
      questionID: form.questionID,
      thursday: form.thursday,
      friday: form.friday
    )
  }
}
