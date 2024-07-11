// ServiceLog.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Действия пользователя
enum LogAction {
    case userOpenRecipeScene(String)
    case userOpenRecipe(String)
    case userSharedRecipe(String)

    // MARK: - Public Methods

    func log(fileURL: URL) {
        let command = LogCommand(action: self)
        LogerInvoker.shared.addLogCommand(command, fileURL: fileURL)
    }
}

/// Записывает действия пользователя. Command
final class LogCommand {
    // MARK: - Public Properties

    var logMessage: String {
        switch action {
        case .userOpenRecipeScene:
            return "Пользователь открыл экран рецептов"
        case let .userOpenRecipe(title):
            return "Пользователь открыл рецепт под названием: \(title)"
        case let .userSharedRecipe(title):
            return "Пользователь поделился рецептом: \(title)"
        }
    }

    // MARK: - Private Properties

    private let action: LogAction

    // MARK: - Initializers

    init(action: LogAction) {
        self.action = action
    }
}

/// Логирует сообщения в файл. Receiver
final class Logger {
    // MARK: - Public Methods

    func writeMessageToLog(message: String, fileURL: URL) {
        do {
            try writeLog(message: message, fileURL: fileURL)
        } catch {}
    }

    func writeLog(message: String, fileURL: URL) throws {
        let data = (message + "\n").data(using: .utf8) ?? Data()
        do {
            if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            } else {
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    try FileManager.default.removeItem(at: fileURL)
                }
                FileManager.default.createFile(atPath: fileURL.path, contents: data)
            }
        }
    }
}

/// Логирует действия пользователя. Invoker
final class LogerInvoker {
    // MARK: - Public Properties

    static let shared = LogerInvoker()

    // MARK: - Private Properties

    private let logger = Logger()
    private let batchSize = 1
    private var commands: [LogCommand] = []

    // MARK: - Public Methods

    func addLogCommand(_ command: LogCommand, fileURL: URL) {
        commands.append(command)
        executeCommandsIfNeeded(fileURL: fileURL)
    }

    // MARK: - Private Methods

    private func executeCommandsIfNeeded(fileURL: URL) {
        guard commands.count >= batchSize else { return }
        commands.forEach { logger.writeMessageToLog(message: $0.logMessage, fileURL: fileURL) }
        commands = []
    }
}
