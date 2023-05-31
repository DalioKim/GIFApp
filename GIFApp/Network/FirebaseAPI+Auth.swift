//
//  FirebaseAPI+Auth.swift
//  GIFApp
//
//  Created by 김동현 on 2023/05/31.
//

import RxSwift
import FirebaseAuth

extension FirebaseAPI {
    private var auth: Auth {
        Auth.auth()
    }
    
    func signIn(withEmail email: String, password: String) -> Single<AuthResponse> {
        Single.create { [weak self] single in
            self?.auth.signIn(withEmail: email, password: password) { auth, error in
                if let error = error {
                    single(.failure(error))
                } else if let auth = auth {
                    single(.success(AuthResponse(auth.user)))
                }
            }
            return Disposables.create()
        }
        
    }
    
    func createUser(withEmail email: String, password: String) -> Single<AuthResponse> {
        Single.create { [weak self] single in
            self?.auth.createUser(withEmail: email, password: password) { auth, error in
                if let error = error {
                    single(.failure(error))
                } else if let auth = auth {
                    single(.success(AuthResponse(auth.user)))
                }
            }
            return Disposables.create()
        }
    }
}
