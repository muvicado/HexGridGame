//
//  LobbyView.swift
//  HexGridGame
//
//  Created by Mark Barclay on 5/15/25.
//

import SwiftUI

struct LobbyView: View {
    @State private var showGame = false

    var body: some View {
        VStack {
            Text("Hex Grid Lobby")
                .font(.largeTitle)
                .padding()

            Button("Start Game") {
                showGame = true
            }
            .fullScreenCover(isPresented: $showGame) {
                GameView()
            }
        }
    }
}
