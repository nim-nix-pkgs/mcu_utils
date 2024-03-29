{
  description = ''Utilities and simple helpers for programming with Nim on embedded MCU devices'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-mcu_utils-main.flake = false;
  inputs.src-mcu_utils-main.ref   = "refs/heads/main";
  inputs.src-mcu_utils-main.owner = "EmbeddedNim";
  inputs.src-mcu_utils-main.repo  = "mcu_utils";
  inputs.src-mcu_utils-main.type  = "github";
  
  inputs."threading".owner = "nim-nix-pkgs";
  inputs."threading".ref   = "master";
  inputs."threading".repo  = "threading";
  inputs."threading".dir   = "master";
  inputs."threading".type  = "github";
  inputs."threading".inputs.nixpkgs.follows = "nixpkgs";
  inputs."threading".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."persistent_enums".owner = "nim-nix-pkgs";
  inputs."persistent_enums".ref   = "master";
  inputs."persistent_enums".repo  = "persistent_enums";
  inputs."persistent_enums".dir   = "master";
  inputs."persistent_enums".type  = "github";
  inputs."persistent_enums".inputs.nixpkgs.follows = "nixpkgs";
  inputs."persistent_enums".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-mcu_utils-main"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-mcu_utils-main";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}