//
//  DI.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation
import Swinject

typealias DI = Swinject.Assembler
typealias Container = Swinject.Container

protocol InstanceAssembly: Assembly {}
protocol SingletonAssembly: Assembly {}

extension Assembler {
    static let instance: Resolver = {
        Assembler.instanceAssembler.resolver
    }()

    static let singleton: Resolver = {
        Assembler.singletonAssembler.resolver
    }()
}

extension Assembler {
    static let instanceAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler(instanceAssemblies,
                                  container: container)
        return assembler
    }()

    static let singletonAssembler: Assembler = {
        let container = Container(defaultObjectScope: .container)
        let assembler = Assembler(singletonAssemblies,
                                  container: container)
        return assembler
    }()
}

extension Assembler {
    static var instanceAssemblies: [InstanceAssembly] {
        // Add InstanceAssembly here
        return [
            DataInstanceAssembly(),
            LoginInstanceAssembly(),
            HomeInstanceAssembly()
        ]
    }

    static var singletonAssemblies: [SingletonAssembly] {
        // Add SingletonAssembly here
        return [
            AppSingletonAssembly(),
            DeviceSingletonAssembly()
        ]
    }
}

extension Resolver {
    func applyInstance(assembly: InstanceAssembly) {
        Assembler.instanceAssembler.apply(assembly: assembly)
    }

    func applyInstance(assemblies: [InstanceAssembly]) {
        Assembler.instanceAssembler.apply(assemblies: assemblies)
    }

    func applySingleton(assembly: SingletonAssembly) {
        Assembler.singletonAssembler.apply(assembly: assembly)
    }

    func applySingleton(assemblies: [SingletonAssembly]) {
        Assembler.singletonAssembler.apply(assemblies: assemblies)
    }
}
