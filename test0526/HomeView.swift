import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("📚 英単語アプリ")
                    .font(.largeTitle)
                    .bold()

                NavigationLink("単語一覧・追加", destination: WordManagerView())
                    .buttonStyle(HomeButtonStyle(color: .orange))

                NavigationLink("クイズに挑戦", destination: QuizView())
                    .buttonStyle(HomeButtonStyle(color: .blue))

                NavigationLink("成績を見る", destination: ScoreView())
                    .buttonStyle(HomeButtonStyle(color: .green))

                NavigationLink("設定", destination: SettingsView())
                    .buttonStyle(HomeButtonStyle(color: .gray))
                
                NavigationLink("スコア履歴を見る", destination: ScoreHistoryView())
                    .buttonStyle(HomeButtonStyle(color: .purple))

            }
            .padding()
        }
    }
}

struct HomeButtonStyle: ButtonStyle {
    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.opacity(configuration.isPressed ? 0.5 : 1))
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}

#Preview {
    HomeView()
}
