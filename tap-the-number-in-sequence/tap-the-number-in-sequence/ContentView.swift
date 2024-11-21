import SwiftUI

struct ContentView: View {
    @State private var numbers: [Int] = []
    @State private var currentNumber: Int = 1
    @State private var score: Int = 0
    @State private var gameOver: Bool = false
    @State private var timer: Timer?
    @State private var timeRemaining: Int = 30
    
    var body: some View {
        ZStack {
            // Background Color
            Color.blue.opacity(0.2).ignoresSafeArea()
            
            VStack {
                // Timer & Score Display
                HStack {
                    Text("Time: \(timeRemaining)s")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                    
                    Spacer()
                    
                    Text("Score: \(score)")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                }
                
                Spacer()
                
                // Grid of Numbers
                if !gameOver {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                        ForEach(numbers, id: \.self) { number in
                            Button(action: {
                                numberTapped(number)
                            }) {
                                Text("\(number)")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 100)
                                    .background(Color.orange)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                            }
                        }
                    }
                } else {
                    // Game Over Message
                    VStack {
                        Text("Game Over!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        
                        Text("Your Score: \(score)")
                            .font(.title)
                            .foregroundColor(.black)
                        
                        Button(action: resetGame) {
                            Text("Restart")
                                .font(.title2)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .onAppear(perform: startGame)
        }
    }
    
    // MARK: - Game Logic
    
    func startGame() {
        score = 0
        timeRemaining = 30
        gameOver = false
        currentNumber = 1
        numbers = []
        generateNumbers()
        
        // Timer for updating the countdown
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                gameOver = true
                timer?.invalidate()
            }
        }
    }
    
    func generateNumbers() {
        for i in 1...10 {
            numbers.append(i)
        }
        numbers.shuffle()
    }
    
    func numberTapped(_ number: Int) {
        if number == currentNumber {
            score += 1
            currentNumber += 1
            if currentNumber > 10 {
                gameOver = true
                timer?.invalidate()
            }
        } else {
            gameOver = true
            timer?.invalidate()
        }
    }
    
    func resetGame() {
        startGame()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

