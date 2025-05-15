//
//  HexagonGridUpdater.swift
//  HexGridGame
//
//  Created by Mark Barclay on 5/15/25.
//

import Foundation
import Combine

class HexagonGridUpdater: ObservableObject {
    @Published var tick = Date()

    private var timer: AnyCancellable?

    init() {
        timer = Timer
            .publish(every: 0.25, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick = Date()
            }
    }

    deinit {
        timer?.cancel()
    }
}
