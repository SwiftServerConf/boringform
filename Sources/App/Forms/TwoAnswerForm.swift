//
//  TwoAnswerForm.swift
//  App
//
//  Created by Martin Lasek on 16.04.19.
//

import Vapor

struct TwoAnswerForm: Content {
  let questionNumber: Int
  let questionID: Int
  let thursday: Bool
  let friday: Bool
}

extension TwoAnswerForm {
  
  enum CodingKeys: String, CodingKey {
    case questionNumber
    case questionID
    case thursday
    case friday
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    var thursday = false
    var friday = false
    
    if let _ = try container.decodeIfPresent(String.self, forKey: .thursday) {
      thursday = true
    }
    
    if let _ = try container.decodeIfPresent(String.self, forKey: .friday) {
      friday = true
    }
    
    try self.init(
      questionNumber: container.decode(Int.self, forKey: .questionNumber),
      questionID: container.decode(Int.self, forKey: .questionID),
      thursday: thursday,
      friday: friday
    )
  }
}
