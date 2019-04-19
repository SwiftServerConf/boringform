//
//  User.swift
//  App
//
//  Created by Martin Lasek on 19.04.19.
//

import FluentMySQL
import Vapor
import Authentication

final class User: MySQLModel {
  var id: Int?
  var username: String
  var password: String
  
  init(id: Int? = nil, username: String, password: String) {
    self.id = id
    self.username = username
    self.password = password
  }
}

extension User: Content {}
extension User: Migration {}

extension User: PasswordAuthenticatable {
  static var usernameKey: WritableKeyPath<User, String> {
    return \User.username
  }
  static var passwordKey: WritableKeyPath<User, String> {
    return \User.password
  }
}

extension User: SessionAuthenticatable {}
