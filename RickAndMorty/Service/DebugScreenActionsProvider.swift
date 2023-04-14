//
//  DebugScreenActionsProvider.swift
//  RickAndMorty
//
//  Created by Ilya Klimenyuk on 13.04.2023.
//

import DebugScreen
import NetworkActivityMonitor

final class DebugScreenActionsProvider: ActionsProvider {

    func makeActions() -> [ActionsProviderModel] {
        let networkMonitorActionModel = ActionModel(title: "Open") {
            NetworkActivityMonitor.shared.open()
        }

        let consoleActionProviderModel = ActionsProviderModel(
            header: "Network activity monitor",
            title: "Open",
            message: "Network activity monitor will open after click",
            actions: [networkMonitorActionModel]
        )

        return [consoleActionProviderModel]
    }

}

