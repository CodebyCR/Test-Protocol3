
import SwiftUI

/// The Protocol
protocol SidebarItem {
    var displayedName: String { get set }
    var image: String { get set }
}

/// Type 1
class Book: SidebarItem, Identifiable, Hashable {
    let id: String
    var displayedName: String
    var image: String

    init(displayedName: String, image: String) {
        self.id = UUID().uuidString
        self.displayedName = displayedName
        self.image = image
    }

    static func getAll() -> [Book] {
        let harryPotter = Book(displayedName: "Harry Potter", image: "folder")
        let harryPotter2 = Book(displayedName: "Harry Potter 2", image: "folder")
        let harryPotter3 = Book(displayedName: "Harry Potter 3", image: "folder")

        return [harryPotter, harryPotter2, harryPotter3]
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.displayedName == rhs.displayedName
    }
}

/// Type 2
class Movie: SidebarItem, Identifiable, Hashable {
    let id: String
    var displayedName: String
    var image: String

    init(displayedName: String, image: String) {
        self.id = UUID().uuidString
        self.displayedName = displayedName
        self.image = image
    }

    static func getAll() -> [Movie] {
        let ironman = Movie(displayedName: "Ironman", image: "folder")
        let ironman2 = Movie(displayedName: "Ironman 2", image: "folder")
        let ironman3 = Movie(displayedName: "Ironman 3", image: "folder")

        return [ironman, ironman2, ironman3]
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.displayedName == rhs.displayedName
    }
}

struct ContentView: View {
    @State var movies = Movie.getAll()
    @State var books = Book.getAll()

    @State var selected: some SidebarItem  = Movie.getAll().first!

    var body: some View {
        NavigationSplitView {
            List(selection: $selected) {
                Section("Books") {
                    ForEach(books) { book in
                        Text(book.displayedName)
                            .tag(book)
                    }
                }

                Section("Movies") {
                    ForEach(movies) { movie in
                        Text(movie.displayedName)
                            .tag(movie)
                    }
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
        } detail: {
            Text("Select an item")
        }
//        .onChange(of: selected, initial: true) {
//            print("SelectedSidebarItem: \(selected.displayedName)")
//        }
    }
}


/// NOTE: The following code works, but don't use a protocol

//struct ContentView: View {
//    @State var movies = Movie.getAll()
//    @State var books = Book.getAll()
//
//    @State var selected: String = Movie.getAll().first!.displayedName
//
//
//var body: some View {
//        NavigationSplitView {
//            List(selection: $selected) {
//                Section("Books") {
//                    ForEach(books) { book in
//                        Text(book.displayedName)
//                            .tag(book.displayedName)
//                    }
//                }
//
//                Section("Movies") {
//                    ForEach(movies) { movie in
//                        Text(movie.displayedName)
//                            .tag(movie.displayedName)
//                    }
//                }
//            }
//            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
//        } detail: {
//            Text("Select an item")
//        }
//        .onChange(of: selected, initial: true) {
//            print("SelectedSidebarItem: \(selected)")
//        }
//    }
//}

#Preview {
    ContentView()
}
