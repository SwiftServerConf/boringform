//
//  ThreeAnswerForm.swift
//  App
//
//  Created by Martin Lasek on 16.04.19.
//

import Vapor

struct ThreeAnswerForm: Content {
  let questionNumber: Int
  let questionID: Int
  let answer: String
}
