import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let controller = HomeAppVC()
        let navigation = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

