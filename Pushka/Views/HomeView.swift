//
//  HomeView.swift
//  Pushka
//
//  Created by Admin on 05/09/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @State private var selectedBook: Book? = nil
    @State private var currentIndex: Int = 0
    @State private var showAddBookView = false
    
    var bookCorouselView : some View {
        // MARK: book carousel
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(Array(homeVM.books.enumerated()), id: \.offset) { index, book in
                        GeometryReader { proxy in
                            let midX = proxy.frame(in: .global).midX
                            let screenMidX = UIScreen.main.bounds.midX
                            let distance = abs(screenMidX - midX)
                            let scale = max(0.8, 1.1 - (distance / 400))
                            
                            AsyncImage(url: book.coverURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 270)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                    .scaleEffect(scale)
                                    .animation(.easeInOut(duration: 0.25), value: scale)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .overlay(Image(systemName: "book.closed")
                                        .foregroundColor(.gray))
                                    .frame(width: 200, height: 270)
                                    .cornerRadius(12)
                                    .scaleEffect(scale)
                            }
                            .onChange(of: distance) { _ in
                                // Detect when the book is centered
                                if distance < 20 {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        selectedBook = book
                                        currentIndex = index
                                    }
                                }
                            }
                        }
                        .frame(width: 200, height: 270)
                    }
                }
                .padding(.horizontal, (UIScreen.main.bounds.width - 200) / 2)
                .padding(.vertical, 60)
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .frame(width: UIScreen.main.bounds.width, height: 400)
            
            // MARK: Book Info
            VStack(spacing: 8) {
                Text(selectedBook?.title ?? "Book Name")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text(selectedBook?.author ?? "Author Name")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.top, 16)
        }
    }
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                // MARK: Background
                if let selectedBook = selectedBook {
                    AsyncImage(url: selectedBook.coverURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .blur(radius: 20)
                            .opacity(0.4)
                            .ignoresSafeArea()
                            .transition(.opacity.animation(.easeInOut(duration: 0.4)))
                    } placeholder: {
                        Color.black.opacity(0.2).ignoresSafeArea()
                    }
                } else {
                    Color.black.opacity(0.3).ignoresSafeArea()
                }
                
                // MARK: Bottom solid background
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: UIScreen.main.bounds.height * 0.39)
                        .ignoresSafeArea(edges: .bottom)
                }
                
                bookCorouselView
                
            }
            .onAppear {
                selectedBook = homeVM.books.first
            }
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("BOOKS")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding()
                }
                
                            
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddBookView = true
                            }label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(Color.gray)
                    }
                }
            }
            
            // MARK: Sheet for AddBookView
            .sheet(isPresented: $showAddBookView) {
                AddBookView()
                    .environmentObject(homeVM)
            }
        }
        
    }
}
#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
