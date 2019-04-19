//
//  FourAnswer.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

import Vapor
import FluentMySQL

struct FourAnswer: MySQLModel {
  var id: Int?
  let questionID: Int
  
  let kitura: Bool
  let vapor: Bool
  let perfect: Bool
  let hacking101: Bool
}

extension FourAnswer: Content {}
extension FourAnswer: Migration {}

extension FourAnswer {
  init(from form: FourAnswerForm) {
    self.init(
      id: nil,
      questionID: form.questionID,
      kitura: form.kitura,
      vapor: form.vapor,
      perfect: form.perfect,
      hacking101: form.hacking101
    )
  }
}
