//
//  Q1.swift
//  App
//
//  Created by Martin Lasek on 16.04.19.
//

import Vapor

struct FourAnswerForm: Content {
  let questionNumber: Int
  let questionID: Int
  let kitura: Bool
  let vapor: Bool
  let perfect: Bool
  let hacking101: Bool
}

extension FourAnswerForm {
  
  enum CodingKeys: String, CodingKey {
    case kitura
    case vapor
    case perfect
    case hacking101
    case questionID
    case questionNumber
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    var kitura = false
    var vapor = false
    var perfect = false
    var hacking101 = false
    
    if let _ = try container.decodeIfPresent(String.self, forKey: .kitura) {
      kitura = true
    }
    
    if let _ = try container.decodeIfPresent(String.self, forKey: .vapor) {
      vapor = true
    }
    
    if let _ = try container.decodeIfPresent(String.self, forKey: .perfect) {
      perfect = true
    }
    
    if let _ = try container.decodeIfPresent(String.self, forKey: .hacking101) {
      hacking101 = true
    }
    
    try self.init(
      questionNumber: container.decode(Int.self, forKey: .questionNumber),
      questionID: container.decode(Int.self, forKey: .questionID),
      kitura: kitura,
      vapor: vapor,
      perfect: perfect,
      hacking101: hacking101
    )
  }
}
