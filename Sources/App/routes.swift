import Vapor
import FluentMySQL
import Authentication

public func routes(_ router: Router) throws {
  
  router.get(Routes.index) { req -> Future<View> in
    struct IndexContext: Encodable {
      let navigation = Navigation.home
    }
    
    return try req.view().render("index", IndexContext())
  }
  
  let authController = AuthController()
  router.get(Routes.login, use: authController.renderLogin)
  router.get(Routes.register, use: authController.renderRegister)
  router.get(Routes.logout, use: authController.logout)
  router.post(Routes.login, use: authController.login)
  router.post(Routes.register, use: authController.register)
  
  let outcomeController = OutcomeController()
  router.get(Routes.rangeOutcome, use: outcomeController.rangeOutcome)
  router.get(Routes.fourOutcome, use: outcomeController.fourOutcome)
  router.get(Routes.freeOutcome, use: outcomeController.freeOutcome)
  router.get(Routes.twoOutcome, use: outcomeController.twoOutcome)
  router.get(Routes.threeOutcome, use: outcomeController.threeOutcome)
  
  
  let questionController = QuestionController()
  let answerController = AnswerController(questionController: questionController)
  
  // MARK: Protected
  
  let authSessionRouter = router.grouped(User.authSessionsMiddleware())
  authSessionRouter.post("login", use: authController.login)
  
  let protectedRouter = authSessionRouter.grouped(RedirectMiddleware<User>(path: "/login"))
  
  // GET
  protectedRouter.get(Routes.q1, use: questionController.question1)
  protectedRouter.get(Routes.q2, use: questionController.question2)
  protectedRouter.get(Routes.q3, use: questionController.question3)
  protectedRouter.get(Routes.q4, use: questionController.question4)
  protectedRouter.get(Routes.q5, use: questionController.question5)
  protectedRouter.get(Routes.q6, use: questionController.question6)
  protectedRouter.get(Routes.q7, use: questionController.question7)
  protectedRouter.get(Routes.q8, use: questionController.question8)
  protectedRouter.get(Routes.q9, use: questionController.question9)
  protectedRouter.get(Routes.q10, use: questionController.question10)
  protectedRouter.get(Routes.q11, use: questionController.question11)
  
  // POST
  protectedRouter.post(Routes.q1, use: answerController.fourAnswer)
  protectedRouter.post(Routes.q2, use: answerController.rangeAnswer)
  protectedRouter.post(Routes.q3, use: answerController.freeAnswer)
  protectedRouter.post(Routes.q4, use: answerController.freeAnswer)
  protectedRouter.post(Routes.q5, use: answerController.twoAnswer)
  protectedRouter.post(Routes.q6, use: answerController.rangeAnswer)
  protectedRouter.post(Routes.q7, use: answerController.rangeAnswer)
  protectedRouter.post(Routes.q8, use: answerController.rangeAnswer)
  protectedRouter.post(Routes.q9, use: answerController.threeAnswer)
  protectedRouter.post(Routes.q10, use: answerController.threeAnswer)
  protectedRouter.post(Routes.q11, use: answerController.freeAnswer)
}

class Question{}

enum QuestionError: Error {
  case questionIdIsNil
  case questionNotFound(number: Int)
}
