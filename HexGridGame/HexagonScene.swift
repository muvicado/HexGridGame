//
//  HexagonScene.swift
//  HexGridGame
//
//  Created by Mark Barclay on 5/15/25.
//

import SpriteKit
import Combine

class HexagonScene: SKScene {
    private var cancellable: AnyCancellable?
    private var hexNodes: [SKShapeNode] = []
    private let updater: HexagonGridUpdater
    private var isRunning = true
    private var toggleButton: SKLabelNode!

    init(updater: HexagonGridUpdater) {
        self.updater = updater
        super.init(size: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        backgroundColor = .black
        drawHexGrid()
        setupToggleButton()

        cancellable = updater.$tick
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                if self?.isRunning == true {
                    self?.updateHexColors()
                }
            }
    }

    func drawHexGrid() {
        let hexSize: CGFloat = 40.0
        let rows = 10
        let cols = 6
        let dx = hexSize * 3/2
        let dy = hexSize * sqrt(3)

        for row in 0..<rows {
            for col in 0..<cols {
                let x = CGFloat(col) * dx
                let y = CGFloat(row) * dy + (col % 2 == 0 ? 0 : dy / 2)

                let hex = SKShapeNode(path: hexPath(radius: hexSize))
                hex.position = CGPoint(x: x + 50, y: y + 50)
                hex.strokeColor = .white
                hex.fillColor = .gray
                hex.lineWidth = 1.5
                addChild(hex)
                hexNodes.append(hex)
            }
        }
    }

    func setupToggleButton() {
        toggleButton = SKLabelNode(text: "Pause")
        toggleButton.fontName = "Helvetica-Bold"
        toggleButton.fontSize = 24
        toggleButton.fontColor = .white
        toggleButton.position = CGPoint(x: size.width / 2, y: size.height - 150)
        toggleButton.name = "toggleButton"
        addChild(toggleButton)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        if nodesAtPoint.contains(where: { $0.name == "toggleButton" }) {
            isRunning.toggle()
            toggleButton.text = isRunning ? "Pause" : "Resume"
        }
    }

    func updateHexColors() {
        for hex in hexNodes {
            hex.fillColor = .init(hue: CGFloat.random(in: 0...1), saturation: 0.8, brightness: 0.9, alpha: 1.0)
        }
    }

    func hexPath(radius: CGFloat) -> CGPath {
        let path = UIBezierPath()
        for i in 0..<6 {
            let angle = CGFloat(i) * .pi / 3
            let x = cos(angle) * radius
            let y = sin(angle) * radius
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.close()
        return path.cgPath
    }
}

