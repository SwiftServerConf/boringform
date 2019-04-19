import Vapor
import FluentMySQL

public func routes(_ router: Router) throws {
  
  router.get(Routes.index) { req -> Future<View> in
    struct IndexContext: Encodable {
      let navigation = Navigation.home
    }
    
    return try req.view().render("index", IndexContext())
  }
  
  let outcomeController = OutcomeController()
  router.get(Routes.rangeOutcome, use: outcomeController.rangeOutcome)
  router.get(Routes.fourOutcome, use: outcomeController.fourOutcome)
  router.get(Routes.freeOutcome, use: outcomeController.freeOutcome)
  router.get(Routes.twoOutcome, use: outcomeController.twoOutcome)
  router.get(Routes.threeOutcome, use: outcomeController.threeOutcome)
  
  
  let questionController = QuestionController()
  let answerController = AnswerController(questionController: questionController)
  
  // GET
  router.get(Routes.q1, use: questionController.question1)
  router.get(Routes.q2, use: questionController.question2)
  router.get(Routes.q3, use: questionController.question3)
  router.get(Routes.q4, use: questionController.question4)
  router.get(Routes.q5, use: questionController.question5)
  router.get(Routes.q6, use: questionController.question6)
  router.get(Routes.q7, use: questionController.question7)
  router.get(Routes.q8, use: questionController.question8)
  router.get(Routes.q9, use: questionController.question9)
  router.get(Routes.q10, use: questionController.question10)
  router.get(Routes.q11, use: questionController.question11)
  
  // POST
  router.post(Routes.q1, use: answerController.fourAnswer)
  router.post(Routes.q2, use: answerController.rangeAnswer)
  router.post(Routes.q3, use: answerController.freeAnswer)
  router.post(Routes.q4, use: answerController.freeAnswer)
  router.post(Routes.q5, use: answerController.twoAnswer)
  router.post(Routes.q6, use: answerController.rangeAnswer)
  router.post(Routes.q7, use: answerController.rangeAnswer)
  router.post(Routes.q8, use: answerController.rangeAnswer)
  router.post(Routes.q9, use: answerController.threeAnswer)
  router.post(Routes.q10, use: answerController.threeAnswer)
  router.post(Routes.q11, use: answerController.freeAnswer)
}

class Question{}

enum QuestionError: Error {
  case questionIdIsNil
  case questionNotFound(number: Int)
}
