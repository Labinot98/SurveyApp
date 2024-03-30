
import XCTest
import Combine
@testable import SurveyApp

class SurveyInteractorTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var interactor: SurveyInteractor!
    var mockRepository: MockSurveyRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockSurveyRepository()
        interactor = SurveyInteractor(repository: mockRepository)
    }

    override func tearDown() {
        cancellables = []
        super.tearDown()
    }

    func testFetchQuestions() {
        let expectedQuestions = [Question(id: 1, question: "Question 1"), Question(id: 2, question: "Question 2")]
        mockRepository.fetchQuestionsResult = Result<[Question], Error>.success(expectedQuestions)
        let expectation = expectation(description: "fetchQuestions")
        interactor.fetchQuestions()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
                }
                expectation.fulfill()
            } receiveValue: { receivedQuestions in
                XCTAssertEqual(receivedQuestions.count, expectedQuestions.count)
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testSubmitAnswer() {
        let answer = Answer(id: 1, answer: "Answer 1")
        mockRepository.submitAnswerResult = Result<Void, Error>.success(())
        let expectation = expectation(description: "submitAnswer")
        interactor.submitAnswer(answer: answer)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
                }
                expectation.fulfill()
            } receiveValue: { _ in
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }
}



class MockSurveyRepository: SurveyRepository {
    
    var fetchQuestionsResult: Result<[Question], Error>!
    var submitAnswerResult: Result<Void, Error>!
    
    func fetchQuestions() -> AnyPublisher<[Question], Error> {
        return fetchQuestionsResult.publisher.eraseToAnyPublisher()
    }
    
    func submitAnswer(answer: Answer) -> AnyPublisher<Void, Error> {
        return submitAnswerResult.publisher.eraseToAnyPublisher()
    }
}
