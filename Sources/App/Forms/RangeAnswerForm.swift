//
//  Q2.swift
//  App
//
//  Created by Martin Lasek on 16.04.19.
//

import Vapor

struct RangeAnswerForm: Content {
  let questionNumber: Int
  let questionID: Int
  let range: Int
}
