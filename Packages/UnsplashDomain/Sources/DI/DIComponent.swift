//
//  DIComponent.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Root
import UnsplashCore

public final class DIComponent: Component<EmptyDependency>, RootDependency {
    var apiService: APIServicing {
        shared {
            APIService()
        }
    }
    public init() {
        super.init(dependency: EmptyComponent())
    }
}
