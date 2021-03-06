//
// Created by Vova Stelmashchuk on 09.06.2022.
//

import Foundation
import Alamofire

typealias Filters = [FilterGroupData]

let goodRelationId = 1
let toolRelationId = 2
let tagRelationId = 3

class FilterDataSource {

    private var dataSource: DataSource

    public init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    func getFilterGroups() -> [FilterGroupData] {
        [
            FilterGroupData(
                    id: goodRelationId,
                    name: "Інгрідієнти",
                    items: getGoodsFilterItems()),
            FilterGroupData(
                    id: tagRelationId,
                    name: "Інше",
                    items: getTagFilterItems()),
            FilterGroupData(
                    id: toolRelationId,
                    name: "Інструменти",
                    items: getToolsFilterItems()),
        ]
    }

    private func getGoodsFilterItems() -> [FilterItemData] {
        dataSource.getGoods().map { item in
            FilterItemData(id: item.id, name: item.name)
        }
    }

    private func getToolsFilterItems() -> [FilterItemData] {
        dataSource.getTools().map { item in
            FilterItemData(id: item.id, name: item.name)
        }
    }

    private func getTagFilterItems() -> [FilterItemData] {
        dataSource.getTags().map { tag in
            FilterItemData(id: tag.id, name: tag.name)
        }
    }
}

struct FilterGroupData: Decodable {
    let id: Int
    let name: String
    let items: [FilterItemData]
}

struct FilterItemData: Decodable {
    let id: Int
    let name: String
}
