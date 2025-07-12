//
//  InfoView.swift
//  WordScramble
//
//  Created by Наташа Спиридонова on 11.07.2025.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - App Icon Section
                    HStack {
                        Image(systemName: "textformat.abc")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("WordScramble")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("Версия 1.0")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    // MARK: - How to Play Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Как играть")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            InfoRow(
                                icon: "1.circle.fill",
                                text: "Используйте буквы из основного слова для создания новых слов"
                            )
                            
                            InfoRow(
                                icon: "2.circle.fill", 
                                text: "Каждое слово должно содержать минимум 3 буквы"
                            )
                            
                            InfoRow(
                                icon: "3.circle.fill",
                                text: "Нельзя использовать одно и то же слово дважды"
                            )
                            
                            InfoRow(
                                icon: "4.circle.fill",
                                text: "Все слова должны быть реальными словами"
                            )
                        }
                    }
                    
                    // MARK: - Scoring Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Подсчет очков")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            InfoRow(
                                icon: "star.fill",
                                text: "Чем длиннее слово, тем больше очков"
                            )
                            
                            InfoRow(
                                icon: "star.fill",
                                text: "Каждая буква = 1 очко"
                            )
                        }
                    }
                    
                    // MARK: - Developer Info
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Разработчик")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Наташа Спиридонова")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
            .navigationTitle("О приложении")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Готово") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Helper Views
private struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.blue)
                .frame(width: 20)
            
            Text(text)
                .font(.body)
            
            Spacer()
        }
    }
}

#Preview {
    InfoView()
} 
