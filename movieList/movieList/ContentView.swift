import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var isDone: Bool = false
}

struct ContentView: View {
    @State private var movies: [Movie] = []
    @State private var newMovieTitle = ""
    @State private var newMovieDescription = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(movies) { movie in
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text(movie.description)
                                .font(.subheadline)
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                toggleMovieCompletion(movie)
                            }) {
                                Image(systemName: movie.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(movie.isDone ? .green : .gray)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.lilac)
                .cornerRadius(8)

                HStack {
                    TextField("Movie Title", text: $newMovieTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Movie Description", text: $newMovieDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: addMovie) {
                        Text("Add Movie")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
            }
            .padding()
            .navigationTitle("Movie List")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Text("Powered by Washington Pedrini").italic().underline().padding(.bottom, 8))
        }
    }

    private func addMovie() {
        guard !newMovieTitle.isEmpty && !newMovieDescription.isEmpty else { return }
        let newMovie = Movie(title: newMovieTitle, description: newMovieDescription)
        movies.append(newMovie)
        newMovieTitle = ""
        newMovieDescription = ""
    }

    private func toggleMovieCompletion(_ movie: Movie) {
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies[index].isDone.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    static let lilac = Color(red: 0.87, green: 0.81, blue: 0.95)
}

