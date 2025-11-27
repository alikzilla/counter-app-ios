import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [Counter]
    @State private var count = 0
    
    private var counter: Counter {
        if let existing = counters.first {
            return existing
        } else {
            let new = Counter(count: 0)
            modelContext.insert(new)
            return new
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(counter.count.description)
                .font(.system(size: 60, weight: .bold))
            Text(count.description)
            
            HStack(spacing: 30) {
                Button("-") {
                    decrement()
                }
                .font(.largeTitle)
                .padding()
                
                Button("+") {
                    increment()
                }
                .font(.largeTitle)
                .padding()
            }
            
            Button("Reset") {
                reset()
            }
            .foregroundColor(.red)
            .padding(.top, 20)
        }
        .padding()
    }
    
    private func increment() {
        counter.count += 1
        count += 1
    }
    
    private func decrement() {
        counter.count -= 1
        count -= 1
    }
    
    private func reset() {
        counter.count = 0
        count = 0
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Counter.self, inMemory: true)
}
