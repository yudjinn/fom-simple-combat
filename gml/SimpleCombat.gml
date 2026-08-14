// Simple Combat
//
// There is no per-monster HP/damage table to patch anymore (that data-file
// override pipeline is gone). Instead this intercepts every hit in the
// combat.damage drain loop: outgoing hits (player -> monster) are forced
// lethal, and incoming hits (monster -> player) are clamped to 1 damage.

function __simple_combat_runtime() {
    if (global[$ "__simple_combat"] == undefined) {
        global.__simple_combat = { registered_hooks: undefined };
    }
    return global.__simple_combat;
}

function simple_combat_register_callbacks() {
    var _rt = __simple_combat_runtime();
    if (_rt.registered_hooks != undefined) return;
    _rt.registered_hooks = true;

    mmapi_filter("combat.damage", simple_combat_combat_damage);
    mmapi_filter("player.incoming_damage", simple_combat_player_incoming_damage);
}

// combat.damage is a FILTER: mutate/return the tarball, or undefined to keep it.
function simple_combat_combat_damage(_value, _ctx) {
    // _value is the damage tarball (obj_damage_tarball) for this hit.
    if (!instance_exists(_value)) return undefined; // an earlier mod already dropped the hit
    if (_value.target != CombatTarget.Player) {
        // _ctx is the obj_damage_receiver; its parent_id is the monster
        // being hit (set by create_receiver). _value.parent_id is the
        // *attacker*, not the target, so it's no good for reading hp here.
        var _monster = _ctx.parent_id;
        var _hp = (_monster != undefined && instance_exists(_monster)) ? _monster[$ "hit_points"] : undefined;
        if (_hp == undefined) _hp = 99999; // fallback if we can't read hp for some reason

        // This bypasses checks for things like clods that will reduce the damage to 1
        _value.damage = max(_hp, 1);
        _value.instant_kill = true;
    }
    return undefined; // keep the (mutated) tarball
}

// player.incoming_damage is a FILTER: return replacement final damage, or undefined.
function simple_combat_player_incoming_damage(_value, _ctx) {
    // The engine already computes this as min(-1, defense - tarball.damage),
    // so a defined value here is always <= -1. Clamp it to exactly -1 so
    // every monster hit costs the player 1 point of health.
    if (_value == undefined) return undefined;
    return -1;
}

mmapi_mod_declare("simple_combat", "1.0.0");
simple_combat_register_callbacks();
