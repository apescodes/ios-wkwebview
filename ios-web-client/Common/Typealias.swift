//
//  Typealias.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/21/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import Foundation

typealias VoidCallback = () -> Void
typealias Action<T> = (T) -> Void
typealias Func<TResult> = () -> TResult
typealias Delegate<T, V> = (T, V) -> Void
