//
//  AddWeight.swift
//  Health_Weight
//
//  Created by Boss on 10/06/2025.
//

import SwiftUI

struct Add: View {
    @EnvironmentObject var route: Router
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Button {
                route.navigateTo(.add)
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding()
            .background(Color.green)
            .clipShape(Circle())
            .padding(5)
            .background(Color.gray.opacity(0.6))
            .clipShape(Circle())
            .offset(y: offsetY)
            .onAppear {
                shakeLoop()
            }
        }
    }
    
func shakeLoop() {
       withAnimation(.easeInOut(duration: 0.1)) {
           offsetY = -6
       }
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
           withAnimation(.easeInOut(duration: 0.1)) {
               offsetY = 6
           }
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
               withAnimation(.easeInOut(duration: 0.1)) {
                   offsetY = 0
               }
               // Dừng 0.3s rồi lặp lại
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                   shakeLoop()
               }
           }
       }
   }
}

#Preview {
    Add()
}
