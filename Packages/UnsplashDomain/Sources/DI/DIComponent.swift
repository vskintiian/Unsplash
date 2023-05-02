//
//  DIComponent.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Root
import UIKit
import UnsplashCore
import Extensions

public final class DIComponent: Component<EmptyDependency>, RootDependency {
    public var apiService: APIServicing {
        shared { APIService() }
    }

    private var imageFetchService: ImageFetchServicing {
        shared {
            ImageFetchService()
        }
    }

    public init() {
        super.init(dependency: EmptyComponent())

        UIImageView.imageFetchService = imageFetchService
    }
}
