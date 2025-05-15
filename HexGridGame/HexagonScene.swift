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
    private let buttonTopOffset: CGFloat = 150  // Distance from top

    private var selectedHex: SKShapeNode?

    init(updater: HexagonGridUpdater) {
        self.updater = updater
        super.init(size: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 0.6, green: 0.4, blue: 0.15, alpha: 1.0) // Dark brown
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

        // Remove old hexes
        for node in hexNodes {
            node.removeFromParent()
        }
        hexNodes.removeAll()

        for row in 0..<rows {
            for col in 0..<cols {
                let x = CGFloat(col) * dx
                let y = CGFloat(row) * dy + (col % 2 == 0 ? 0 : dy / 2)

                let hex = SKShapeNode(path: hexPath(radius: hexSize))
                hex.position = CGPoint(x: x + 50, y: y + 50)
                hex.strokeColor = .white
                hex.fillColor = .gray
                hex.lineWidth = 1.5
                hex.name = "hexagon"
                addChild(hex)
                hexNodes.append(hex)
            }
        }

        // Re-add selected hex last to bring it visually on top
        if let selected = selectedHex, hexNodes.contains(selected) {
            selected.removeFromParent()
            addChild(selected)
        }
    }

    func setupToggleButton() {
        toggleButton = SKLabelNode(text: "Pause")
        toggleButton.fontName = "Helvetica"
        toggleButton.fontSize = 24
        toggleButton.fontColor = SKColor(red: 0.96, green: 0.89, blue: 0.76, alpha: 1.0) // Beige
        toggleButton.position = CGPoint(x: size.width / 2, y: size.height - buttonTopOffset)
        toggleButton.name = "toggleButton"
        addChild(toggleButton)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)

        if touchedNodes.contains(where: { $0.name == "toggleButton" }) {
            isRunning.toggle()
            toggleButton.text = isRunning ? "Pause" : "Resume"
            return
        }

        for node in touchedNodes {
            if let hex = node as? SKShapeNode, hex.name == "hexagon" {
                toggleHexagonSelection(hex)
                break
            }
        }
    }

    func toggleHexagonSelection(_ hex: SKShapeNode) {
        if selectedHex == hex {
            // Deselect
            hex.lineWidth = 1.5
            hex.strokeColor = .white
            selectedHex = nil
        } else {
            // Deselect previous
            selectedHex?.lineWidth = 1.5
            selectedHex?.strokeColor = .white

            // Highlight new
            hex.lineWidth = 5.0
            hex.strokeColor = .black
            selectedHex = hex

            // Bring selected to top
            hex.removeFromParent()
            addChild(hex)
        }
    }

    func updateHexColors() {
        for hex in hexNodes {
            hex.fillColor = .init(hue: CGFloat.random(in: 0...1), saturation: 0.8, brightness: 0.9, alpha: 1.0)
        }

        // Re-apply highlight styling (in case lineWidth/strokeColor were overridden)
        if let selected = selectedHex {
            selected.lineWidth = 5.0
            selected.strokeColor = .black
            selected.removeFromParent()
            addChild(selected)
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
