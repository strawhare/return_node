import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let spriteNode = SKSpriteNode()
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 0/255, green: 150/255, blue: 50/255, alpha: 1.0)
        
        //set node
        spriteNode.size = CGSize(width: 160, height: 200)
        spriteNode.position = self.view!.center
        spriteNode.texture = SKTexture(imageNamed: "card_back")
        spriteNode.name = "back"
        addChild(spriteNode)
        
        //set button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.setTitle("open", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.center = CGPoint(x: view.center.x, y: view.frame.height - 100)
        button.addTarget(self, action: #selector(rotateCard), for: .touchUpInside)
        self.view!.addSubview(button)
        
    }
    
    @objc func rotateCard() {
        //二重タップ防止
        self.view!.isUserInteractionEnabled = false
        
        //first transform
        let rotate_action = SKAction.scaleX(by: 0, y: 1.0, duration: 0.5)
        let re_rotate_action = SKAction.scaleX(to: 1.0, y: 1.0, duration: 0.5)
        self.spriteNode.run(rotate_action, completion: {
            self.spriteNode.texture = self.changeImge()
            self.spriteNode.run(re_rotate_action, completion: {
                //二重タップ防止 解除
                self.view!.isUserInteractionEnabled = true
            })
        })
    }
    
    func changeImge() -> SKTexture{
        if spriteNode.name == "back" {
            spriteNode.name = "joker"
            return SKTexture(imageNamed: "card_joker")
        }else {
            spriteNode.name = "back"
            return SKTexture(imageNamed: "card_back")
        }
    }
}
