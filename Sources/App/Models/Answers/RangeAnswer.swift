//
//  RangeAnswer.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import Vapor
import FluentMySQL

struct RangeAnswer: MySQLModel {
  var id: Int?
  let questionID: Int
  let range: Int
}

extension RangeAnswer: Content {}
extension RangeAnswer: Migration {}

extension RangeAnswer {
  init(from form: RangeAnswerForm) {
    self.init(
      id: nil,
      questionID: form.questionID,
      range: form.range
    )
  }
}
