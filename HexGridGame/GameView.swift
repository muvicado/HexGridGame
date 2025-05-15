//
//  GameView.swift
//  HexGridGame
//
//  Created by Mark Barclay on 5/15/25.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @StateObject private var updater = HexagonGridUpdater()

    var scene: SKScene {
        let scene = HexagonScene(updater: updater)
        scene.size = CGSize(width: 400, height: 800)
        scene.scaleMode = .resizeFill
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
