//
//  testView.swift
//  Pushka
//
//  Created by Admin on 05/09/25.
//

import SwiftUI

struct testView: View {
    let books = DeveloperPreview.shared.books
    
    var body: some View {
        VStack{
            ScrollView(.horizontal){
                LazyHStack(spacing: 22){
                    ForEach(books) { book in
                        AsyncImage(url: book.coverURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay(
                                    Image(systemName: "book.closed")
                                        .foregroundColor(.gray)
                                )
                        }
                        .padding(10)
                        .frame(width: 300, height: 400)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    }
                }
            }
        }
    }
}


/*
       carousel using scrollTransition function
 //
 //  HomeView.swift
 //  Pushka
 //
 //  Created by Admin on 05/09/25.
 //

 import SwiftUI

 struct HomeView: View {
     let books = DeveloperPreview.shared.books
     @State private var selectedBook : Book? = nil
     @State private var currentIndex : Int  = 0
     
     var body: some View {
         ZStack{
             // Background
             if let selectedBook = selectedBook {
                 AsyncImage(url: selectedBook.coverURL) { image in
                     image
                         .resizable()
                         .scaledToFill()
                         .blur(radius: 20)
                         .opacity(0.4)
                         .ignoresSafeArea()
                 } placeholder: {
                     Color.black.opacity(0.2)
                         .ignoresSafeArea()
                 }
             } else {
                 Color.black.opacity(0.3)
                     .ignoresSafeArea()
             }
             
             VStack {
                 Spacer()
                     Rectangle()
                     .fill(Color.black) // Change color/opacity as you like
                         .frame(height: UIScreen.main.bounds.height * 0.39) // bottom 40%
                         .ignoresSafeArea(edges: .bottom)
                         }
             
             //Overlay
             VStack {
                 // bookshelf scroll
                 ScrollView(.horizontal) {
                     LazyHStack(spacing: 16) {
                         ForEach(books) { book in
                             AsyncImage(url: book.coverURL) { image in
                                 image
                                     .resizable()
                                     .scaledToFill()
                                     .frame(width: 200, height: 270)
                                     .cornerRadius(12)
                                     .shadow(radius: 5)
                                     .scrollTransition(axis: .horizontal) { content, phase in
                                         content
                                             .scaleEffect(phase.isIdentity ? 1.0 : 0.5)
                                             .opacity(phase.isIdentity ? 1.0 : 0.6)
                                             
                                     }
                             } placeholder: {
                                 Rectangle()
                                     .fill(Color.gray.opacity(0.3))
                                     .overlay(
                                         Image(systemName: "book.closed")
                                             .foregroundColor(.gray)
                                     )
                                     .frame(width: 200, height: 270)
                                     .cornerRadius(12)
                                     .scrollTransition(axis: .horizontal) { content, phase in
                                         content
                                             .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                             .opacity(phase.isIdentity ? 1.0 : 0.6)
                                             
                                     }
                             }
                             .scrollTargetLayout()
                             .onTapGesture {
                                 withAnimation(.easeInOut) {
                                     selectedBook = book
                                 }
                             }
                         }
                     }
                     .padding(.horizontal, (UIScreen.main.bounds.width - 200) / 2)
                 }
                 .scrollTargetBehavior(.viewAligned)
                 .scrollIndicators(.hidden)
                 .frame(width: UIScreen.main.bounds.width , height: 400)
                 
                 // Book Info
                 Text(selectedBook?.title ?? "Book Name")
                     .font(.largeTitle)
                     .foregroundColor(Color.white)
                 
                 Text(selectedBook?.author ?? "Author Name")
                     .font(.title)
                     .foregroundColor(Color.white)
                     .padding()
                 
                 
                 
             }
         }
     }
 }

 #Preview {
     HomeView()
 }

 
 */

#Preview {
    testView()
}
