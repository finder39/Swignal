//
//  Swignal5Args.swift
//  Plug
//
//  Created by Joseph Neuman on 7/6/16.
//  Copyright © 2016 Plug. All rights reserved.
//

import Foundation

public class Swignal5Args<A,B,C,D,E>: SwignalBase {
    
    public override init() {
    }
    
    public func addObserver<L: AnyObject>(observer: L, callback: (observer: L, arg1: A, arg2: B, arg3: C, arg4: D, arg5: E) -> ()) {
        let observer = Observer5Args(swignal: self, observer: observer, callback: callback)
        addSwignalObserver(observer)
    }
    
    public func fire(arg1: A, arg2: B, arg3: C, arg4: D, arg5: E) {
        synced(self) {
            for watcher in self.swignalObservers {
                watcher.fire(arg1, arg2, arg3, arg4, arg5)
            }
        }
    }
}

private class Observer5Args<L: AnyObject,A,B,C,D,E>: ObserverGenericBase<L> {
    let callback: (observer: L, arg1: A, arg2: B, arg3: C, arg4: D, arg5: E) -> ()
    
    init(swignal: SwignalBase, observer: L, callback: (observer: L, arg1: A, arg2: B, arg3: C, arg4: D, arg5: E) -> ()) {
        self.callback = callback
        super.init(swignal: swignal, observer: observer)
    }
    
    override func fire(args: Any...) {
        if let arg1 = args[0] as? A,
            let arg2 = args[1] as? B,
            let arg3 = args[2] as? C,
            let arg4 = args[3] as? D,
            let arg5 = args[4] as? E {
            fire(arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5)
        } else {
            assert(false, "Types incorrect")
        }
    }
    
    private func fire(arg1 arg1: A, arg2: B, arg3: C, arg4: D, arg5: E) {
        if let observer = observer {
            callback(observer: observer, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5)
        }
    }
}