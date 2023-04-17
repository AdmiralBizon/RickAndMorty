//
//  DebugScreenActionsProvider.swift
//  RickAndMorty
//
//  Created by Ilya Klimenyuk on 13.04.2023.
//

import DebugScreen
import netfox
import NetShears

final class DebugScreenActionsProvider: ActionsProvider {

    func makeActions() -> [ActionsProviderModel] {
        let openNetfoxConsoleAction = ActionModel(title: "Netfox") {
            NFX.sharedInstance().show()
        }

        let openNetShearsConsoleAction = ActionModel(title: "NetShears") {
            NetShears.shared.presentNetworkMonitor()
        }

        let consoleActionsProviderModel = ActionsProviderModel(
            header: "Network monitors",
            title: "Open",
            message: "Console will open after click",
            actions: [openNetfoxConsoleAction, openNetShearsConsoleAction]
        )

        return [consoleActionsProviderModel]
    }

}

