import Quick
import Nimble

#if USE_COMBINE
import Combine
#else
import CombineX
#endif

class MergeSpec: QuickSpec {
    
    override func spec() {
        
        it("should merge 3 upstream") {
            let subjects = [
                PassthroughSubject<Int, CustomError>(),
                PassthroughSubject<Int, CustomError>(),
                PassthroughSubject<Int, CustomError>(),
            ]

            let merge = Publishers.Merge3(subjects[0], subjects[1], subjects[2])

            let sub = CustomSubscriber<Int, CustomError>(receiveSubscription: { s in
                s.request(.unlimited)
            }, receiveValue: { v in
                return .none
            }, receiveCompletion: { c in
            })

            merge.subscribe(sub)
            
            10.times {
                subjects[$0 % 3].send($0)
            }

            let events = (0..<10).map {
                CustomSubscriber<Int, CustomError>.Event.value($0)
            }
            expect(sub.events).to(equal(events))
        }
    }
}