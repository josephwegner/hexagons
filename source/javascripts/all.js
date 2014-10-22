//= require_tree .

window.onLoad = function() {
  var game = new Game()

  var centerTile = new Tile(game, 0, 0)
  game.addTile(centerTile)

  setInterval(function() {
    game.generateRandomTile()
  }, 500);
};

window.yStepConstant = Math.cos(30 * (Math.PI / 180)) * 50

