import SwiftUI

struct BookDetailView: View {
    @State var book: Book
    @Environment(\.dismiss) private var dismiss
    
    @State private var rotation: Double = 0
    @State private var tiltAmount: CGSize = .zero
    @State private var showStatusMenu = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(colors: [.black, .gray.opacity(0.4)],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                // 3D Cover Image
                AsyncImage(url: book.coverURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 320)
                        .cornerRadius(16)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 0, y: 5)
                        .rotation3DEffect(
                            .degrees(rotation),
                            axis: (x: tiltAmount.height, y: tiltAmount.width, z: 0)
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        tiltAmount = value.translation
                                        rotation = Double(value.translation.width / 10)
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        tiltAmount = .zero
                                        rotation = 0
                                    }
                                }
                        )
                        .padding(.top, 40)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 320)
                        .cornerRadius(16)
                        .padding(.top, 40)
                }
                
                // Book Info Section
                VStack(spacing: 18) {
                    Text(book.title)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text(book.author)
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                    
                    // Dropdown for Status Selection
                    Menu {
                        ForEach(BookStatus.allCases) { status in
                            Button(action: {
                                withAnimation {
                                    book.status = status
                                }
                            }) {
                                Label(status.rawValue,
                                      systemImage: status == book.status ? "checkmark" : "")
                            }
                        }
                    } label: {
                        HStack {
                            Text(book.status.rawValue)
                                .foregroundColor(.white)
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .padding(.top, 10)
                    
                    //Book Description
                    if let description = book.description, !description.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Description")
                                .font(.headline)
                                .foregroundColor(.white)
                                                    
                            Text(description)
                                .font(.body)
                                .foregroundColor(.white.opacity(0.85))
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil) // Ensures full visibility
                                .fixedSize(horizontal: false, vertical: true) // Allows full expansion
                                .padding(.top, 4)
                                .lineSpacing(6)
                            }
                            .padding(.top, 16)
                    } else {
                        Text("No description available.")
                            .foregroundColor(.white.opacity(0.6))
                            .italic()
                            .padding(.top, 16)
                        }
                    // Done button
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Done")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.gradient)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    BookDetailView(book: Book(
        id: UUID(),
        title: "Atomic Habits",
        author: "James Clear",
        coverURL: URL(string: "https://images-na.ssl-images-amazon.com/images/I/91bYsX41DVL.jpg")!,
        description: "An easy and proven way to build good habits and break bad ones."
    ))
}

