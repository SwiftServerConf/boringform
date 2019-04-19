//
//  FreeAnswerForm.swift
//  App
//
//  Created by Martin Lasek on 16.04.19.
//
import Vapor

struct FreeAnswerForm: Content {
  let questionNumber: Int
  let questionID: Int
  let description: String
}
