//
//  AuthController.swift
//  App
//
//  Created by Martin Lasek on 19.04.19.
//

import Vapor
import Crypto

final class AuthController {
  func renderLogin(req: Request) throws -> Future<View> {
    return try req.view().render("login")
  }
  
  func renderRegister(req: Request) throws -> Future<View> {
    return try req.view().render("register")
  }
  
  func login(req: Request) throws -> Future<Response> {
    
    return try req.content.decode(User.self).flatMap { user in
      return User.authenticate(
        username: user.username,
        password: user.password,
        using: BCryptDigest(),
        on: req
      ).map { user in
          guard let user = user else {
            return req.redirect(to: Routes.login)
          }
        
        try req.authenticateSession(user)
        
        return req.redirect(to: Routes.q1)
      }
    }
  }
  
  func register(req: Request) throws -> Future<Response> {
    
    return User.query(on: req).all().flatMap { userList in
      
      // Only allow one user to exist
      guard userList.count == 0 else {
        return req.future(req.redirect(to: Routes.login))
      }
      
      return try req.content.decode(User.self).flatMap { user in
        
        user.password = try BCryptDigest().hash(user.password)
        
        return user.save(on: req).map { _ in
          return req.redirect(to: Routes.login)
        }
      }
    }
  }
  func logout(req: Request) throws -> Response {
    try req.unauthenticateSession(User.self)
    return req.redirect(to: Routes.login)
  }
}
