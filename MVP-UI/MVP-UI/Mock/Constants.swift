// Constants.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Foundation

/// Константы
final class Constants {
    /// Режим работы на моках вместо сервера
    static var isMockMode: Bool {
        #if Mock
        true
        #else
        false
        #endif
    }
}
