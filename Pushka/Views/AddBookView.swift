//
//  AddBookView.swift
//  Pushka
//
//  Created by Admin on 13/10/25.
//

import SwiftUI

struct AddBookView: View {
    @EnvironmentObject var homeVM : HomeViewModel
    @StateObject private var viewModel = AddBookViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var showSuccessAlert = false
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Search Bar
                HStack {
                    TextField("Search books by title or author", text: $viewModel.searchText)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    Button(action: {
                        Task {
                            await viewModel.searchBooks()
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .padding(10)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //  Book List
                if viewModel.isLoading {
                    ProgressView("Searching books...")
                        .padding(.top, 20)
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.books) { book in
                                HStack(spacing: 12) {
                                    // Book Cover
                                    AsyncImage(url: book.coverURL) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 90)
                                            .cornerRadius(8)
                                    } placeholder: {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 60, height: 90)
                                            .overlay(
                                                Image(systemName: "book.fill")
                                                    .font(.system(size: 30))
                                                    .foregroundColor(.gray)
                                            )
                                    }
                                    
                                    // Book Info
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(book.title)
                                            .font(.headline)
                                        Text(book.author)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    
                                    // Add Button
                                    Button(action: {
                                        homeVM.addBook(book)
                                        showSuccessAlert = true
                                            // Automatically dismiss after a short delay
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                            dismiss()
                                        }
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 1)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                    }
                }
                
                
            }
            .overlay {
                if showSuccessAlert {
                    VStack {
                    Spacer()
                    Text(" Book Added!")
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .padding(.bottom, 40)
                    }
                    .animation(.easeInOut, value: showSuccessAlert)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            showSuccessAlert = false
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}


#Preview {
    AddBookView()
        .environmentObject(HomeViewModel())
}

