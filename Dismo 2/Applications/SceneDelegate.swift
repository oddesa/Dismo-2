//
//  SceneDelegate.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit
import Shared
import MovieReviews
import MovieCollections
import MovieDetails
import MovieDiscover

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = MovieDiscoverRouter.createMovieDiscoverModule()
        window?.makeKeyAndVisible()
        
        Router.route = { destination in
            switch destination {
            case let .reviewsPage(id):
                let reviewsVC = MovieReviewsRouter.createMovieReviewsModule(with: id)
                UIApplication.topViewController()?.navigationController?.pushViewController(reviewsVC, animated: true)
            case let .detailsPage(details):
                let detailsVC = MovieDetailsRouter.createMovieDetailsModule(with: details)
                UIApplication.topViewController()?.navigationController?.pushViewController(detailsVC, animated: true)
            case let .collectionsPage(genre):
                let collectionsVC = MovieCollectionsRouter.createMovieCollectionsModule(with: genre)
                UIApplication.topViewController()?.navigationController?.pushViewController(collectionsVC, animated: true)
            default:
                return
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

