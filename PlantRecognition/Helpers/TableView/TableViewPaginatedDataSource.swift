//
//  Created by Igor Kasyanenko on 23.06.2021.
//

import Foundation
import UIKit

class TableViewPaginatedDataSource<
    ItemsProvider: PaginatedItemsProvider
>
{
    private let itemsProvider: ItemsProvider
    
    private let constants = PaginatorConstants()
    private lazy var resultsPerPageCount: Int = constants.resultsPerPage
    private var currentPage: Int = 1
    private var lastResponseElementsCount: Int?
    private var isFetching: Bool = false
    
    init(itemsProvider: ItemsProvider) {
        self.itemsProvider = itemsProvider
    }
    
    /// Paginate from start
    func loadInitialItems(
        request: ItemsProvider.RequestType,
        completion: @escaping (Result<[ItemsProvider.ItemType], DataSourceError>) -> Void
    ) {
        getItems(
            page: currentPage,
            perPageResults: resultsPerPageCount,
            request: request,
            fetchNewPage: false,
            completion: completion
        )
    }
    
    /// Load next pages (if exists)
    func loadNextItems(
        request: ItemsProvider.RequestType,
        completion: @escaping (Result<[ItemsProvider.ItemType], DataSourceError>) -> Void
    ) {
        getItems(
            page: currentPage + 1,
            perPageResults: resultsPerPageCount,
            request: request,
            fetchNewPage: true,
            completion: completion
        )
    }
}

private extension TableViewPaginatedDataSource {
    // MARK: - Service private methods
    
    func getItems(
        page: Int,
        perPageResults: Int,
        request: ItemsProvider.RequestType,
        fetchNewPage: Bool,
        completion: @escaping (Result<[ItemsProvider.ItemType], DataSourceError>) -> Void
    ) {
        let dontHaveNextItems = (lastResponseElementsCount ?? 0) < resultsPerPageCount
        if !fetchNewPage && dontHaveNextItems  /*, currentPage > (totalPagesCount ?? .max)*/ {
            completion(.failure(.dontHaveNextItems))
            return
        }
        
        // чтобы отсекать повторные запросы
        if isFetching {
            completion(.failure(.dataIsLoading))
            return
        } else {
            isFetching = true
        }
        
        itemsProvider.loadItems(
            request: request,
            pagination: .init(pageNumber: page, pageItemsCount: perPageResults)
        ) { [weak self] result in
            self?.isFetching = false
            
            self?.parseResult(
                page: page,
                fetchNewPage: fetchNewPage,
                result: result,
                completion: completion
            )
        }
    }

    func parseResult(
        page: Int,
        fetchNewPage: Bool,
        result: Result<PaginatedItemsProviderResult<ItemsProvider.ItemType>, ItemsProvider.ErrorType>,
        completion: @escaping (Result<[ItemsProvider.ItemType], DataSourceError>) -> Void
    ) {
        switch result {
        case let .success(response):
            lastResponseElementsCount = response.items.count

            if fetchNewPage, response.items.count > 0 {
                currentPage = page
            }
            
            completion(.success(response.items))
        case let .failure(error):
            completion(.failure(.networkError(error: error)))
        }
    }
}

private extension TableViewPaginatedDataSource {
    struct PaginatorConstants {
        let resultsPerPage: Int = 10
        let startingPage: Int = 1
    }
}

extension TableViewPaginatedDataSource {
    enum DataSourceError: Error {
        case dataIsLoading
        case dontHaveNextItems
        case networkError(error: ItemsProvider.ErrorType)
    }
}

protocol PaginatedItemsProvider: AnyObject {
    associatedtype RequestType
    
    associatedtype ItemType
    associatedtype ErrorType: Error
    
    func loadItems(
        request: RequestType,
        pagination: PaginationConfig,
        callback: (Result<PaginatedItemsProviderResult<ItemType>, ErrorType>) -> Void
    )
    
}

struct PaginationConfig {
    private let pageNumber: Int
    private let pageItemsCount: Int
    
    var pagesRepresentation: Pages {
        .init(pageNumber: pageNumber, pageItemsCount: pageItemsCount)
    }
    
    var offsetLimitRepresentation: OffsetLimit {
        let offset = pageNumber * pageItemsCount
        let limit = pageItemsCount
        return .init(offset: offset, limit: limit)
    }
    
    init(pageNumber: Int, pageItemsCount: Int) {
        self.pageNumber = pageNumber
        self.pageItemsCount = pageItemsCount
    }
}

extension PaginationConfig {
    struct OffsetLimit {
        let offset: Int
        let limit: Int
    }
    
    struct Pages {
        let pageNumber: Int
        let pageItemsCount: Int
    }
}

struct PaginatedItemsProviderResult<ItemType> {
    let items: [ItemType]
}

//protocol PaginatedItemsMapper: AnyObject {
//    associatedtype InputItemType
//    associatedtype OutputItemType
//
//    func mapItems(_ items: [InputItemType]) -> [OutputItemType]
//
//}
