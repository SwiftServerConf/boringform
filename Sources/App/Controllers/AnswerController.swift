//
//  AnswerController.swift
//  App
//
//  Created by Martin Lasek on 16.04.19.
//
import Vapor

final class AnswerController {
  var questionController: QuestionController
  
  init(questionController: QuestionController) {
    self.questionController = questionController
  }
  
  func fourAnswer(req: Request) throws -> Future<Response> {
    return try req.content.decode(FourAnswerForm.self).flatMap { answerForm in
      FourAnswer(from: answerForm).save(on: req).map { _ in
        req.redirect(to: self.getRedirect(for: answerForm.questionNumber))
      }
    }
  }
  
  func rangeAnswer(req: Request) throws -> Future<Response> {
    return try req.content.decode(RangeAnswerForm.self).flatMap { answerForm in
      RangeAnswer.init(from: answerForm).save(on: req).map { _ in
        req.redirect(to: self.getRedirect(for: answerForm.questionNumber))
      }
    }
  }
  
  func freeAnswer(req: Request) throws -> Future<Response> {
    return try req.content.decode(FreeAnswerForm.self).flatMap { answerForm in
      FreeAnswer.init(from: answerForm).save(on: req).map { _ in
        req.redirect(to: self.getRedirect(for: answerForm.questionNumber))
      }
    }
  }
  
  func twoAnswer(req: Request) throws -> Future<Response> {
    return try req.content.decode(TwoAnswerForm.self).flatMap { answerForm in
      TwoAnswer.init(from: answerForm).save(on: req).map { _ in
        req.redirect(to: self.getRedirect(for: answerForm.questionNumber))
      }
    }
  }
  
  func threeAnswer(req: Request) throws -> Future<Response> {
    debugPrint(req.content)
    return try req.content.decode(ThreeAnswerForm.self).flatMap { answerForm in
      ThreeAnswer.init(from: answerForm).save(on: req).map { _ in
        req.redirect(to: self.getRedirect(for: answerForm.questionNumber))
      }
    }
  }
  
  private func getRedirect(for number: Int) -> String {
    switch number {
      case 1: return Routes.q2
      case 2: return Routes.q3
      case 3: return Routes.q4
      case 4: return Routes.q5
      case 5: return Routes.q6
      case 6: return Routes.q7
      case 7: return Routes.q8
      case 8: return Routes.q9
      case 9: return Routes.q10
      case 10: return Routes.q11
      default: return Routes.index
    }
  }
}
