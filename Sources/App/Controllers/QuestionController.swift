//
//  QuestionController.swift
//  App
//
//  Created by Martin Lasek on 16.04.19.
//
import Vapor

final class QuestionController {
  
  func question1(req: Request) throws -> Future<View> {
    let number = 1
    return try FourQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question1", question)
    }
  }
  
  func question2(req: Request) throws -> Future<View> {
    let number = 2
    return try RangeQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question2", question)
    }
  }
  
  func question3(req: Request) throws -> Future<View> {
    let number = 3
    return try FreeQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question3", question)
    }
  }
  
  func question4(req: Request) throws -> Future<View> {
    let number = 4
    return try FreeQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question4", question)
    }
  }
  
  func question5(req: Request) throws -> Future<View> {
    let number = 5
    return try TwoQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question5", question)
    }
  }
  
  func question6(req: Request) throws -> Future<View> {
    let number = 6
    return try RangeQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question6", question)
    }
  }
  
  func question7(req: Request) throws -> Future<View> {
    let number = 7
    return try RangeQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question7", question)
    }
  }
  
  func question8(req: Request) throws -> Future<View> {
    let number = 8
    return try RangeQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question8", question)
    }
  }
  
  func question9(req: Request) throws -> Future<View> {
    let number = 9
    return try ThreeQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question9", question)
    }
  }
  
  func question10(req: Request) throws -> Future<View> {
    let number = 10
    return try ThreeQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question10", question)
    }
  }
  
  func question11(req: Request) throws -> Future<View> {
    let number = 11
    return try FreeQuestion.find(on: req, byNumber: number).flatMap { question in
      try req.view().render("Questions/question11", question)
    }
  }
}
