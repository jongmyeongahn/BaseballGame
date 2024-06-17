
import Foundation

let answer = Answer()
answer.start()

class Answer {
    var recordManager = RecordManager()
    
    var sets = 0
    func start() {
        let answer = makeAnswer()
        let answerString = String(answer)
        let answerArray = Array(answerString)
        print("정답은 \(answer)")
        print("환영합니다! 원하시는 번호를 입력해주세요")
        let mychoice = choice()
        switch mychoice {
        case 1 :
            print("게임을 시작합니다")
            var count = 0
            while true {
                count += 1
                var strike = 0
                var ball = 0
                let myresult = myAnswer()
                let result = Array(String(myresult))
                for i in 0..<result.count {
                    if result[i] == answerArray[i] {
                        strike += 1
                    } else if answerString.contains(result[i]) {
                        ball += 1
                    }
                }
                if strike != 0 && ball == 0 {
                    print("\(strike)스트라이크 ")
                }else if ball != 0 && strike == 0 {
                    print("\(ball)ball")
                }else if strike != 0 && ball != 0 {
                    print("\(strike)스트라이크 \(strike)ball")
                }
                if strike == 3 {
                    print("정답입니다.")
                    sets += 1
                    recordManager.add(sets: sets, count: count)
                    return start()
                }
            }
            
        case 2:
            recordManager.showManager()
            start()
            
        case 3:
            print("게임을 종료합니다.")
            break
        default:
            break
        }
    }

    func choice() -> Int {
        print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
        while true {
            guard let input = readLine(), let number = Int(input) else {
                print("올바른 값을 입력해주세요")
                continue
            }
            
            switch number {
            case 1...3 :
                return number
            default:
                print("1 ,2, 3 중에 선택해주세요.")
            }
        }
    }
    func makeAnswer() -> Int {
        var result: Set<Int> = []
        while result.count < 3 {
            result.insert(Int.random(in: 0...9))
        }
        let answerArray = Array(result)
        if answerArray[0] == 0  {
            return makeAnswer()
        } else {
            let answer = answerArray[0] * 100 + answerArray[1] * 10 + answerArray[2] * 1
            return answer
        }
    }
    func myAnswer() -> Int {
        while true {
            guard let input = readLine(), let number = Int(input) else {
                print("올바른 값을 입력해주세요")
                continue
            }

            switch number{
            case 100...999 :
                return number
            default:
                print("숫자 3개를 입력해주세요.")
            }
        }
    }
}

class RecordManager {
    var dic : [Int: Int] = [:]
    func add(sets: Int ,count: Int) {
        dic[sets] = count
    }
    func showManager() {
        for i in dic {
            print("\(i.key)번째 :시도횟수 - \(i.value)")
        }
    }
}


