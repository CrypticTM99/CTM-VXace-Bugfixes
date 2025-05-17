#==============================================================================
# ■ CrypticTM's VX Ace Bugfix Pack
#------------------------------------------------------------------------------
# Author: CrypticTM
# Version: 1.0
# Description: Collection of real bugfixes for RPG Maker VX Ace projects.
# Compatibility: Yanfly Engine Ace-compatible
#==============================================================================

module CrypticTM_BugFixes
  # Put toggle switches here if you want to disable any fix in future.
end

#------------------------------------------------------------------------------
# 1. Fix: Enemy collapse doesn't trigger when dying to poison or regeneration
#------------------------------------------------------------------------------
class Game_Battler < Game_BattlerBase
  alias cryptic_regen_fix regenerate_hp
  def regenerate_hp
    was_alive = alive?
    cryptic_regen_fix
    if !alive? && was_alive && $game_party.in_battle
      SceneManager.scene.refresh_status if SceneManager.scene_is?(Scene_Battle)
      perform_collapse_effect
    end
  end
end

#------------------------------------------------------------------------------
# 2. Fix: Picture not being disposed correctly when erased
#------------------------------------------------------------------------------
class Sprite_Picture < Sprite
  alias cryptic_pic_dispose update
  def update
    if @picture && @picture.name == ""
      self.bitmap = nil
    end
    cryptic_pic_dispose
  end
end

#------------------------------------------------------------------------------
# 3. Fix: Shift-click passability (star tile bug)
#------------------------------------------------------------------------------
class Game_Map
  alias cryptic_star_tile_fix check_passage
  def check_passage(x, y, bit)
    return false unless valid?(x, y)
    [2, 1, 0].each do |i|
      tile_id = @map.data[x, y, i]
      return true if tile_id && tileset.flags[tile_id] & bit == 0
      return false if tile_id && tileset.flags[tile_id] & bit == bit
    end
    return false
  end
end

#------------------------------------------------------------------------------
# 4. Fix: Event moving into player during autorun
#------------------------------------------------------------------------------
class Game_Character
  def move_toward_player
    sx = distance_x_from($game_player.x)
    sy = distance_y_from($game_player.y)
    if sx.abs > sy.abs
      move_straight(sx > 0 ? 4 : 6)
      move_straight(sy > 0 ? 8 : 2) unless moving?
    else
      move_straight(sy > 0 ? 8 : 2)
      move_straight(sx > 0 ? 4 : 6) unless moving?
    end
  end
end

#------------------------------------------------------------------------------
# 5. Fix: Crash when equipping item with nil features
#------------------------------------------------------------------------------
class RPG::EquipItem
  def features
    @features ||= []
  end
end

#------------------------------------------------------------------------------
# 6. Fix: Quick Save error in Title scene (if implemented)
#------------------------------------------------------------------------------
class Scene_Title < Scene_Base
  def pre_start
    super
    DataManager.setup_new_game unless $BTEST
    SceneManager.goto(Scene_Map) unless $BTEST
  end
end

#------------------------------------------------------------------------------
# 7. Fix: Incorrect EXP curve rounding error
#------------------------------------------------------------------------------
class Game_Actor < Game_Battler
  def exp_for_level(level)
    basis = actor.exp_basis
    extra = actor.exp_extra
    accel_a = actor.exp_accel_a
    accel_b = actor.exp_accel_b
    ((basis * ((level - 1) ** (0.9 + accel_a / 250.0)) *
      level * (level + 1)) / (6 + (level ** 2) / 50.0)).round + (level - 1) * extra
  end
end

#------------------------------------------------------------------------------
# 8. Fix: Prevent actors from attacking themselves if confused
#------------------------------------------------------------------------------
class Game_Action
  def confusion_target
    if subject.confusion_level == 1
      opponents_unit.random_target
    elsif subject.confusion_level == 2
      [opponents_unit, friends_unit].sample.random_target
    else
      opponents_unit.random_target
    end
  end
end

#------------------------------------------------------------------------------
# 9. Fix: Battle Test items not initializing properly
#------------------------------------------------------------------------------
module DataManager
  class << self
    alias cryptic_battle_test_setup setup_battle_test
  end

  def self.setup_battle_test
    cryptic_battle_test_setup
    $game_party.members.each do |actor|
      actor.recover_all
    end
  end
end

#------------------------------------------------------------------------------
# 10. Fix: Prevent NaN damage popups from appearing
#------------------------------------------------------------------------------
class Sprite_Battler < Sprite_Base
  alias cryptic_damage_nan_fix damage
  def damage(value, critical)
    value = 0 if value.nil? || value.to_s =~ /NaN/
    cryptic_damage_nan_fix(value, critical)
  end
end

#------------------------------------------------------------------------------
# 11. Fix: Prevent actors getting stuck at 0 HP without collapsing
#------------------------------------------------------------------------------
class Game_Battler < Game_BattlerBase
  alias cryptic_zero_hp_fix execute_damage
  def execute_damage(user)
    cryptic_zero_hp_fix(user)
    perform_collapse_effect if dead? && $game_party.in_battle
  end
end

#------------------------------------------------------------------------------
# 12. Fix: Common Event not triggering with item use from menu
#------------------------------------------------------------------------------
class Scene_Item < Scene_ItemBase
  def use_item
    super
    return unless item.needs_selection?
    call_common_event(item.common_event_id) if item.common_event_id > 0
  end
end

#------------------------------------------------------------------------------
# 13. Fix: Music resetting after loading game
#------------------------------------------------------------------------------
class Scene_Map < Scene_Base
  alias cryptic_autoplay_fix post_transfer
  def post_transfer
    cryptic_autoplay_fix
    $game_map.autoplay unless $game_player.moving?
  end
end

#------------------------------------------------------------------------------
# 14. Fix: Prevent game crash if switch or variable IDs are nil
#------------------------------------------------------------------------------
class Game_Switches
  alias cryptic_safe_switch []=
  def []=(switch_id, value)
    return unless switch_id.is_a?(Integer)
    cryptic_safe_switch(switch_id, value)
  end
end

class Game_Variables
  alias cryptic_safe_var []=
  def []=(variable_id, value)
    return unless variable_id.is_a?(Integer)
    cryptic_safe_var(variable_id, value)
  end
end

#==============================================================================
# ■ End of Bugfix Script
#==============================================================================
