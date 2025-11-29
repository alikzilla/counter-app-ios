import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [Counter]

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
        VStack(spacing: 40) {
            
            Text(counter.count.description)
                .font(.system(size: 80, weight: .heavy, design: .rounded))
                .padding(.top, 50)
                .animation(.spring(), value: counter.count)

            HStack(spacing: 40) {
                RoundButton(title: "-", color: .red) {
                    decrement()
                }
                
                RoundButton(title: "+", color: .green) {
                    increment()
                }
            }

            Button(action: reset) {
                Text("Reset")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 14)
                    .background(Color.gray.opacity(0.7))
                    .clipShape(Capsule())
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }

    private func increment() {
        withAnimation(.spring()) {
            counter.count += 1
        }
    }

    private func decrement() {
        withAnimation(.spring()) {
            counter.count -= 1
        }
    }

    private func reset() {
        withAnimation(.easeInOut) {
            counter.count = 0
        }
    }
}

struct RoundButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .frame(width: 80, height: 80)
                .foregroundColor(.white)
                .background(color)
                .clipShape(Circle())
                .shadow(radius: 10)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Counter.self, inMemory: true)
}
