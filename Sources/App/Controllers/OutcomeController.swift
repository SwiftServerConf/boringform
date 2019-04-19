//
//  OutcomeController.swift
//  App
//
//  Created by Martin Lasek on 17.04.19.
//
import Vapor

final class OutcomeController {
  
  // MARK: - Four Answer
  
  func fourOutcome(req: Request) throws -> Future<View> {
    struct FourOutcomeContext: Encodable {
      let navigation = Navigation.outcome
      let route = Routes.fourOutcome
      let fourList: [FourQuestionAnswer]
    }
    
    struct FourQuestionAnswer: Encodable {
      let fourQuestion: FourQuestion
      let fourAnswerContextList: Future<[FourAnswerContext]>
    }
    
    struct FourAnswerContext: Encodable {
      let description: String
      let count: Double
    }
    
    // Using `all()` althought there's only `one` question.
    return FourQuestion.query(on: req).all().flatMap { fourQuestionList in
      
      let fourList = try fourQuestionList.map { fourQuestion -> FourQuestionAnswer in
        let fourAnswerContextList = try fourQuestion.answer.query(on: req).all().map { answerList -> [FourAnswerContext]in
          let kituraCount = answerList.filter({$0.kitura}).count
          let vaporCount = answerList.filter({$0.vapor}).count
          let perfectCount = answerList.filter({$0.perfect}).count
          let hacking101Count = answerList.filter({$0.hacking101}).count
          
          let countMultiplier = 100 / Double (kituraCount + vaporCount + perfectCount + hacking101Count)
          
          return [
            FourAnswerContext(description: "kitura", count: Double(kituraCount) * countMultiplier),
            FourAnswerContext(description: "vapor", count: Double(vaporCount) * countMultiplier),
            FourAnswerContext(description: "perfect", count: Double(perfectCount) * countMultiplier),
            FourAnswerContext(description: "hacking101", count: Double(hacking101Count) * countMultiplier),
          ]
        }
        
        return FourQuestionAnswer(fourQuestion: fourQuestion, fourAnswerContextList: fourAnswerContextList)
      }
      
      return try req.view().render("outcome/four-outcome", FourOutcomeContext(fourList: fourList))
    }
  }
  
  // MARK: - Range
  
  func rangeOutcome(req: Request) throws -> Future<View> {
    
    struct RangeOutcomeContext: Encodable {
      let navigation = Navigation.outcome
      let route = Routes.rangeOutcome
      let rangeList: [RangeQuestionAnwer]
    }
    
    struct RangeQuestionAnwer: Encodable {
      let rangeQuestion: RangeQuestion
      let rangeAnswerContextList: Future<[RangeAnswerContext]>
    }
    
    struct RangeAnswerContext: Encodable {
      let range: Int
      var count: Double
    }
    
    return RangeQuestion.query(on: req).all().flatMap { questionList in
      
      let rangeList = try questionList.map { question -> RangeQuestionAnwer in
        
        let racList = try question.answer.query(on: req).all().map { answerList -> [RangeAnswerContext] in
          
          var reducedAnswerList = answerList.reduce([RangeAnswerContext]()) { result, rangeAnswer in
            var tempResult = result
          
            if let index = result.firstIndex(where: { rangeAnswerContext in rangeAnswerContext.range == rangeAnswer.range}) {
              tempResult[index].count = tempResult[index].count + 1
            } else {
              tempResult.append(RangeAnswerContext(range: rangeAnswer.range, count: 1))
            }
            
            return tempResult
          }
          
          let countMultiplier = 100 / Double(answerList.count)
          
          for index in 0...reducedAnswerList.count-1 {
            reducedAnswerList[index].count = reducedAnswerList[index].count * countMultiplier
          }
          
          // Fill up array with missing range answers
          var rangeAnswerDummyList = [
            RangeAnswerContext(range: 1, count: 0),
            RangeAnswerContext(range: 2, count: 0),
            RangeAnswerContext(range: 3, count: 0),
            RangeAnswerContext(range: 4, count: 0),
            RangeAnswerContext(range: 5, count: 0)
          ]
          
          for answer in reducedAnswerList {
            rangeAnswerDummyList = rangeAnswerDummyList.filter { $0.range != answer.range }
          }
          
          reducedAnswerList = rangeAnswerDummyList + reducedAnswerList
          
          // Sort based on range number descending
          reducedAnswerList = reducedAnswerList.sorted { $0.range < $1.range }
          
          return reducedAnswerList
        }
        
        return RangeQuestionAnwer(rangeQuestion: question, rangeAnswerContextList: racList)
      }
      
      let context = RangeOutcomeContext(rangeList: rangeList)
      return try req.view().render("outcome/range-outcome", context)
    }
  }
  
  // MARK: Free
  
  func freeOutcome(req: Request) throws -> Future<View> {
    
    struct FreeOutcomeContext: Encodable {
      let navigation = Navigation.outcome
      let route = Routes.freeOutcome
      let freeQuestionList: [FreeQuestionAnswer]
    }
    
    struct FreeQuestionAnswer: Encodable {
      let freeQuestion: FreeQuestion
      let freeAnswerContextList: Future<[FreeAnswer]>
    }
    
    return FreeQuestion.query(on: req).all().flatMap { fourQuestionList in
      
      let list = try fourQuestionList.map { fourQuestion in
        FreeQuestionAnswer(
          freeQuestion: fourQuestion,
          freeAnswerContextList: try fourQuestion.answer.query(on: req).all())
      }
      
      return try req.view().render("outcome/free-outcome", FreeOutcomeContext(freeQuestionList: list))
    }
  }
  
  // MARK: Two
  
  func twoOutcome(req: Request) throws -> Future<View> {
    
    struct TwoOutcomeContext: Encodable {
      let navigation = Navigation.outcome
      let route = Routes.twoOutcome
      let twoList: [TwoQuestionAnswer]
    }
    
    struct TwoQuestionAnswer: Encodable {
      let twoQuestion: TwoQuestion
      let twoAnswerContextList: Future<[TwoAnswerContext]>
    }
    
    struct TwoAnswerContext: Encodable {
      let description: String
      let count: Double
    }
    
    // Using `all()` althought there's only `one` question.
    return TwoQuestion.query(on: req).all().flatMap { twoQuestionList in
      
      let twoList = try twoQuestionList.map { twoQuestion -> TwoQuestionAnswer in
        
        let twoAnswerContextList = try twoQuestion.answer.query(on: req).all().map { answerList -> [TwoAnswerContext]in
          let thursdayCount = answerList.filter({$0.thursday}).count
          let fridayCount = answerList.filter({$0.friday}).count
          
          let countMultiplier = 100 / Double (thursdayCount + fridayCount)
          
          return [
            TwoAnswerContext(description: "thursday", count: Double(thursdayCount) * countMultiplier),
            TwoAnswerContext(description: "friday", count: Double(fridayCount) * countMultiplier)
          ]
        }
        
        return TwoQuestionAnswer(twoQuestion: twoQuestion, twoAnswerContextList: twoAnswerContextList)
      }
      
      return try req.view().render("outcome/two-outcome", TwoOutcomeContext(twoList: twoList))
      
    }
  }
  
  // MARK: Three
  
  func threeOutcome(req: Request) throws -> Future<View> {
    
    struct ThreeOutcomeContext: Encodable {
      let navigation = Navigation.outcome
      let route = Routes.threeOutcome
      let threeList: [ThreeQuestionAnswer]
    }
    
    struct ThreeQuestionAnswer: Encodable {
      let threeQuestion: ThreeQuestion
      let threeAnswerContextList: Future<[ThreeAnswerContext]>
    }
    
    struct ThreeAnswerContext: Encodable {
      let description: String
      let count: Double
    }
    
    // Using `all()` althought there's only `one` question.
    return ThreeQuestion.query(on: req).all().flatMap { threeQuestionList in
      
      let threeList = try threeQuestionList.map { threeQuestion -> ThreeQuestionAnswer in
        
        let threeAnswerContextList = try threeQuestion.answer.query(on: req).all().map { answerList -> [ThreeAnswerContext]in
          
          let yes = answerList.filter({$0.answer == "yes"}).count
          let no = answerList.filter({$0.answer == "no"}).count
          let maybe = answerList.filter({$0.answer == "maybe"}).count
          
          let countMultiplier = 100 / Double (yes + no + maybe)
          
          return [
            ThreeAnswerContext(description: "yes", count: Double(yes) * countMultiplier),
            ThreeAnswerContext(description: "no", count: Double(no) * countMultiplier),
            ThreeAnswerContext(description: "maybe", count: Double(maybe) * countMultiplier)
          ]
        }
        
        return ThreeQuestionAnswer(threeQuestion: threeQuestion, threeAnswerContextList: threeAnswerContextList)
      }
      
      return try req.view().render("outcome/three-outcome", ThreeOutcomeContext(threeList: threeList))
    }
  }
}


